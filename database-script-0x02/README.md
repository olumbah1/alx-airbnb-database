# Why i used the UUID().

First I set each user to UUID to generate a 15 long unique identifier that database uses to fetch each row. so, If I want to reference the same user or property in another table (like booking or property), I can't just call UUID() again, because it will generate a different value each time. That I set each user to the UUID to always reference the user. UUID() is called once per entity, stored in variables like @user1_id. Those variables are reused in related tables to maintain correct foreign key references. This keeps IDs unique, realistic, and consistent. since I am using UUID in my Table and has a unique identity.



