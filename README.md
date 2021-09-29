# Sravni Github Actions Workflows

Содержит в себе темплейты Workflow для Github Actions, а именно:
- Build and Test Workflows (Mono repo, Multiservice repo, Backoffices, PHP)
- Publish to Stage Workflows (Mono repo, Multiservice repo, Backoffices, PHP)
- Publish to Prod Workflows (Mono repo, Multiservice repo, Backoffices, PHP)

## Features

- Сборка проектов на каждый пуш, без пуша образа
- Раскатка проекта на стейдж окружение и его создание (при создании ПР)
- Работа с qa-dashboard
- Раскатка проекта на Прод (Azure, при релизе или пуше тега)
- Отправка уведомлений в Slack и Jira

## Installation

Для добавления какого-либо из Workflow необходимо:

 - Зайти во вкладку Action внутри своего проекта
 - Найти в списке "Workflows created by Sravni.ru LLC"
 - Найти интересующий вас Workflow и нажать "Set up this workflow"
 - Добавить в Repository Secrets секрет TEAM с называнием вашей команды

## Tips and Tricks

 - Более подробное README к каждому Worflow можно найти внутри самого YML
 - YML'ы Multiservice, Backoffice, PHP, Jobs практически идентичны, описание только в Multiservice
