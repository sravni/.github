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
 - Найти в списке "By Sravni Tech"
 - Найти интересующий вас Workflow и нажать "Configure"
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

## Модули build-and-test с привязкой к определенной базе данных

Нужны для того, чтобы поднимать временную БД для тестов во время работы GHA. 
Как только build-and-test будет завершен, БД автоматически удалится вместе с завершением работы раннера.

- build-and-test-postgresql - поднимает контейнерную службу с базой данных postgresql
- build-and-test-mongodb - поднимает контейнерную службу с базой данных mongodb
- build-and-test-mysql - поднимает контейнерную службу с базой данных mysql

Пример:

| Параметры | Описание | Обязательный (да/нет) | Значение по умолчанию |
| --- | --- | --- | --- |
| db_image | Официальный docker image БД | Да | Отсутствует |
| db_user_name | Логин пользователя к БД | Да | Отсутствует |
| db_user_psw | Пароль пользователя к БД | Да | Отсутствует |
| db_name | Название БД | Да | Отсутствует |

Ниже представлены строки подключения к каждой из текущих БД.
Обратите внимание, как правильно подключаться к mongoDb, т.к. указанное вами имя БД не нужно указывать внутри строки подключения.

Пример:

| Image | Описание | Пример строки подключения | Примечание |
| --- | --- | --- | --- |
| [mongo](https://hub.docker.com/_/mongo) | Официальный image для mongoDb | mongodb://{db_user_name}:{db_user_psw}@127.0.0.1:27018/admin | MongoDbClient.GetDatabase({db_name}) |
| [mysql](https://hub.docker.com/_/mysql) | Официальный image для mysql | Server=127.0.0.1; Port=3306; Database={db_name}; UserId={db_user_name}; Pwd={db_user_psw}; |  |
| [postgresql](https://hub.docker.com/_/postgres) | Официальный image для postgresql | Host=127.0.0.1;Port=6432;Username={db_user_name};Password={db_user_psw};Database={db_name}; |  |

## Tips and Tricks

 - Более подробное README к каждому Worflow можно найти внутри самого YML или в Jira
