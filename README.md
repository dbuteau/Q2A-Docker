# Question 2 Answer
Question to answer is a stack overflow like website for self hosting.
For more details See: https://github.com/q2a/question2answer 

## This repo
This is an attempt to made a docker q2a instance with some already installed plugins  
Plugins are:
- [qa-filter](https://github.com/ganbox/qa-filter.git)
- [qa-poll](https://github.com/NoahY/q2a-poll.git)
- [qa-user-actibity](https://github.com/svivian/q2a-user-activity-plus.git)
- [qa-user-history](https://github.com/NoahY/q2a-history.git)
- [qa-log-tags](https://github.com/NoahY/q2a-log-tags.git)
- [qa-email-notifications](https://github.com/dbuteau/qa-category-email-notifications.git)[^1]
- [qa-open-question](https://github.com/dbuteau/q2a-plugin-open-questions.git)[^1]
- [qa-ldap-login](https://github.com/zakkak/qa-ldap-login.git)
- [qa-mattermost-notifications](https://github.com/Schoaf/qa-mattermost-notifications.git)

[^1]: warning, due to outdated original plugin repo, the docker target a personnal fork with updated code

## How To
1. git clone https://github.com/dbuteau/Q2A-Docker.git
2. cd Q2A-Docker
3. think to define .env file with Q2A_MYSQL_PASSWORD & Q2A_MYSQL_USER defined in it  
4. docker-compose up -d
