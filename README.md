## Основные понятия

- Монорепа - репозиторий, содержащий один сервис/бэкофис/фронт
- Мультирепа - репозиторий, содержащий в себе несколько сервисов/бэкофисов
- Базовый модуль - workflow, содержащий в себе уже готовый функционал, необходимый для деплоя на стейдж/прод. 
Такие модули триггерятся только при явном вызове через функционал workflow_call с передачей всех необходимых параметров.
- Облегченный вариант - workflow, который содержит в себе необходимый минимум. Вызывает базовый модуль с заранее проставленными параметрами.
В облегченном варианте нужно прописать только наименование своей команды.

## Требования к проекту

- Монорепы:
  - Наличие Dockerfile в корне репозитория
  - Наличие папки .k8s в корне репозитория, содержащей ya-stage.yaml

- Мультирепы:
  - Каждый сервис/бекофис/джоба в репозитории должен лежать в своей папке с
    наименованием *.Service / *.Backoffice / *.Job соответственно
  - Внутри каждого сервиса/бекофиса/джобы должен быть Dockerfile к нему
  - Внутри каждого сервиса/бекофиса/джобы должна быть папка .k8s с ya-stage.yaml внутри

## Список доступных Github Action

- Build and Test (Monorepo, Multirepo, Jobs)
- Publish to Stage (Monorepo, Multirepo, Jobs)
- Publish to Prod (Monorepo, Multirepo, Jobs)
####Дополнительные workflow для Multirepo:
- [Publish to Stage](https://github.com/sravni/.github/blob/master/workflow-templates/sravni-pipeline-publish-to-stage-multi-projects.yml) для всех типов проектов (Service, Backoffice, job), сборка и тесты на каждый push (кроме push`а в мастер) проходят в нем же. Также есть возможность запускать workflow в ручном режиме с указанием namespace и типа проекта
- [Publish to Prod](https://github.com/sravni/.github/blob/master/workflow-templates/sravni-pipeline-publish-to-prod-multi-projects.yml) для всех типов проектов (Service, Backoffice, job), с возможностью делать роллбэк

## Возможности

- Сборка проектов на каждый пуш, без пуша образа
- Раскатка проекта на стейдж окружение и его создание (при создании/изменении ПР)
- Работа с qa-dashboard
- Раскатка проекта на Прод (Azure, при релизе или пуше тега)
- Отправка уведомлений в Slack и Jira
- Возможность мануального деплоя определенной джобы
- Возможность использования нашего раннера для возможности прогона интегротестов

## Добавление Workflow к себе в проект

Для добавления какого-либо из Workflow необходимо:

 - Зайти во вкладку Action внутри своего проекта
 - Найти в списке "Workflows created by Sravni.ru LLC"
 - Найти интересующий вас Workflow и нажать "Set up this workflow"
 - Прописать имя своей команды в env:team вместо <team_name>
 - Создать ya-stage.yaml с описанием чарта под новый стейдж (в Ingress указываем
   stage.yandex.sravni-team.ru вместо qa.sravni-team.ru)

## Базовые модули
 - [Модуль](https://github.com/sravni/.github/blob/master/.github/workflows/sravni-pipeline-build-and-test-multi-project-module.yml) сборки и тестов (Multirepo)
 - [Модуль](https://github.com/sravni/.github/blob/master/.github/workflows/sravni-pipeline-publish-to-stage-multi-projects-module.yml) публикации в yandex stage (Multirepo)
 - [Модуль](https://github.com/sravni/.github/blob/master/.github/workflows/sravni-pipeline-publish-to-azure-multi-projects-module.yml) публикации в azure (Mutlirepo)
 - [Модуль](https://github.com/sravni/.github/blob/master/.github/workflows/sravni-pipeline-create-namespace-module.yml) созадния namespace
 - [Модуль](https://github.com/sravni/.github/blob/master/.github/workflows/sravni-pipeline-get-branch-name-module.yml) получения название ветки (ref)

  Данные модули можно подключать в ваши workflow если нужного готового шаблоны вы не нашли 
## Tips and Tricks

 - Более подробное README к каждому Worflow можно найти внутри самого YML или в Jira
