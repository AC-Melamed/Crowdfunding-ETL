-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
SELECT cf_id,
    SUM(backers_count) as backer_numbers
	FROM campaign as cam
	WHERE (cam.outcome = 'live')
GROUP by cf_id
ORDER by backer_numbers desc;


-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
SELECT bac.cf_id,
	COUNT(backer_id) as backer_numbers
	FROM backers as bac
JOIN campaign as cam on bac.cf_id = cam.cf_id
	WHERE (cam.outcome = 'live')
GROUP by bac.cf_id
ORDER by backer_numbers desc;


-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 
SELECT con.first_name, 
		con.last_name,
		con.email,
		(cam.goal - cam.pledged) as remaining_goal_amount
	INTO email_contacts_remaining_goal_amount
	FROM campaign as cam
INNER JOIN contacts as con on (cam.contact_id = con.contact_id)
	WHERE (cam.outcome = 'live')
ORDER by remaining_goal_amount desc;
-- Check the table
SELECT * FROM email_contacts_remaining_goal_amount

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 
SELECT bac.email,
		bac.first_name,
		bac.last_name,
		cam.cf_id,
		cam.company_name,
		cam.description,
		cam.end_date,
		(cam.goal - cam.pledged) as Left_of_Goal
	INTO email_backers_remaining_goal_amount
	FROM campaign as cam
INNER JOIN backers as bac on (cam.cf_id = bac.cf_id)
	WHERE (cam.outcome = 'live')
ORDER by bac.email desc;
-- Check the table
SELECT * FROM email_backers_remaining_goal_amount;

