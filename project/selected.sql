-- Увімкнення перевірки зовнішніх ключів.
PRAGMA foreign_keys = ON;

--Отримати всі завдання певного користувача.
SELECT * FROM tasks WHERE user_id = 1;

--Вибрати завдання за певним статусом.
SELECT * FROM tasks
WHERE status_id = (SELECT id FROM status WHERE name = 'new');

--Оновити статус конкретного завдання.
UPDATE tasks
SET status_id = 2
WHERE id = 1;

--Отримати список користувачів, які не мають жодного завдання.
SELECT * FROM users
WHERE id NOT IN(SELECT user_id FROM tasks);

--Додати нове завдання для конкретного користувача.
INSERT INTO tasks (title,status_id,user_id)
VALUES ('Finish the project.', 1, 7);

--Отримати всі завдання, які ще не завершено.
SELECT * FROM tasks
WHERE status_id != 3;

--Видалити конкретне завдання.
DELETE FROM tasks WHERE id = 5;

--Знайти користувачів з певною електронною поштою.
SELECT * FROM users WHERE email LIKE 'ivan.ivanov@gmail.com';

--Оновити ім'я користувача.
UPDATE users
SET fullname = 'Volodimir Zelenski'
WHERE id = 10;

--Отримати кількість завдань для кожного статусу.
SELECT COUNT(*) AS count_tasks, status_id
FROM tasks
GROUP BY status_id;

--Отримати завдання, які призначені користувачам з певною доменною частиною електронної пошти.
SELECT *
FROM tasks t
JOIN users u ON t.status_id = u.id
WHERE u.email LIKE '%@goit.ua';

--Отримати список завдань, що не мають опису.
SELECT * FROM tasks
WHERE description IS NULL OR description = '';

--Вибрати користувачів та їхні завдання, які є у статусі.
SELECT *
FROM users u
JOIN tasks t ON u.id = t.user_id
WHERE t.status_id = 2;

--Отримати користувачів та кількість їхніх завдань.
SELECT u.*, COUNT(t.id) AS count_tasks
FROM users u
LEFT JOIN tasks t ON u.id = t.user_id
GROUP BY u.id







