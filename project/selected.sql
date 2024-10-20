--Enable foreign key validation.
PRAGMA foreign_keys = ON;

--Get all tasks of a specific user.
SELECT * FROM tasks WHERE user_id = 1;

--Select a task by a certain status.
SELECT * FROM tasks
WHERE status_id = (SELECT id FROM status WHERE name = 'new');

--Update the status of a specific task.
UPDATE tasks
SET status_id = 2
WHERE id = 1;

--Get a list of users who do not have any tasks.
SELECT * FROM users
WHERE id NOT IN(SELECT user_id FROM tasks);

--Add a new task for a specific user.
INSERT INTO tasks (title,status_id,user_id)
VALUES ('Finish the project.', 1, 7);

--Get all tasks that have not yet been completed.
SELECT * FROM tasks
WHERE status_id != 3;

--Delete a specific task.
DELETE FROM tasks WHERE id = 5;

--Find users with a specific email.
SELECT * FROM users WHERE email LIKE 'ivan.ivanov@gmail.com';

--Update username.
UPDATE users
SET fullname = 'Volodimir Zelenski'
WHERE id = 10;

--Get the number of tasks for each status.
SELECT COUNT(*) AS count_tasks, status_id
FROM tasks
GROUP BY status_id;

--Get tasks that are assigned to users with a specific email domain part.
SELECT *
FROM tasks t
JOIN users u ON t.status_id = u.id
WHERE u.email LIKE '%@goit.ua';

--Get a list of tasks that do not have a description.
SELECT * FROM tasks
WHERE description IS NULL OR description = '';

--Select users and their tasks that are in the status.
SELECT *
FROM users u
JOIN tasks t ON u.id = t.user_id
WHERE t.status_id = 2;

--Get users and the number of their tasks.
SELECT u.*, COUNT(t.id) AS count_tasks
FROM users u
LEFT JOIN tasks t ON u.id = t.user_id
GROUP BY u.id







