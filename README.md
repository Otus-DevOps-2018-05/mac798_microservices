# дз №17 (gitlab-ci-2)
* Добавлены окружения к задачам в пайплайнах
* Добавлены фильтры по тэгам для задач, относящихся к stage и production окружениям
* Добавлены динамические окружения
<!---
## задание со ( * )
* создан новый gitlab-runner который запускает docker-образ c установленным gcloud, обслуживающий только задачи с меткой gcloud
* добавлен api-ключ, монтирующийся на отдельном томе при запуске runner-а gcloud, путь передается через переменные в настройках проекта
* Созданы задачи по созданию и удалению экземпляров вм, помеченные метками gcloud

## задание с ( ** )
* Создана задача создания образа проекта reddit на экземпляре
-->
# дз №16 (gitlab-ci-1)

* создан экземпляр вм для установки докер-образа gitlab
`docker-machine create --driver google --google-project micro-svc --google-zone europe-north1-b --google-machine-type custom-1-3840 --google-open-port 80/tcp --google-open-port 443/tcp  --google-disk-size 100 docker-gitlab`
* добавлен и запущен контейнер gitlab-omnibus
* произведена настройка gitlab через веб-интерфейс
* на сервер gitlab добавлен проект
* добавлен контейнер gitlab-runner
* gitlab-runner зарегистрирован в проекте
* добавлен тест simpletest.rb
* изменен параметр concurrent в /etc/gitlab-runner/config.toml
## задание со ( * )
* Для запуска нескольких экземпляров gittlab-runner создана конфигурация terraform (хотя по моему мнению такая разовая операция более достойна shell-скрипта, который будет как минимум короче, но вначале курса сказали, что это табу ;))
* создана интеграция с каналом #sergey_makeev в DevOps team https://devops-team-otus.slack.com/messages/CB9U1QKPZ

# дз №15 (docker-4)
* запущены образы docker c различными сетевыми драйверами (none, host), как указано на слайдах
* сделана попытка запустить несколько контейнеров nginx с использованием сетового драйвера host. запущенным остался только самый первый, т.к. "последователи" не могут открыть серверный сокет на том же адресе и порту, что и первый веб-сервер.
* создан и проверен docker-compose.yml из слайдов
* docker-compose.yml изменен для параметризации и использования нескольких сетей
* имена контейнеров состоят из имени базовой директории, откуда запускается docker-compose, имени образа без тэга и номера запущенного экземпляра контейнера. Это названте можно изменить через параметр container_name. но в этом случае будет невозможно запукать несколько экземпляров такого контейнера. Ещё возможно выбирать имя базовой директории и образов и смириться с цифрами в конце :)
* создан файл .env с переменными для параметризации docker-compose

## Задание со ( * )
Создан файл docker-compose.override.yml

* Чтобы произвольно менять содержимое контейнера к образам монтируется внешний том с bash-скриптами, которые впоследствии используются в качестве команды запуска контейнера.

* некоторую сложность представляет монтирование тома на машине в gcloud, т.к. туда нужно предварительно скопировать директорию со скриптами, также можно  использовать драйвер nfs или како-го либо облачного хранилища

* для запуска puma в режиме отладки используется директива `command: /bin/sh /dc-scripts/ui-go.sh --debug -w 2`, которая переопределяет команду контейнера. Параметры,
переданные скрипту передаются при вызове puma.

* изменять код приложения


# дз №14 (docker-3)
* созданы образы докер-контейнеров с микросервисами приложения (слайды 1-15)
* при создании образа контейнера ui сигнатуры промежуточных образов первых шагов
 из Dockerfile совпадают с образами первых шагов контейнера comment, поэтому
 выполнение идёт не с первого шага, а вытаскивается из кеша.


## Задание со ( * ) {1}
* для передачи передачи переменных окружения в контейнер используется опция `-e`,
поэтому для запуска контейнеров с измененными сетевыми именами, например при
добавлении к ним суффикса `-01` команда должна выглядеть так образом:
```
docker run -d --network=reddit --network-alias=post-db-01 --network-alias=comment-db-01   mongo:latest
docker run -d --network=reddit --network-alias=comment-01 -e COMMENT_DATABASE_HOST=comment-db-01 mac798/comment:1.0
docker run -d --network=reddit --network-alias=post-01 -e POST_DATABASE_HOST=post-db-01 mac798/post:1.0
docker run -d --network=reddit -e POST_SERVICE_HOST=post-01 -e COMMENT_SERVICE_HOST=comment-01 -p 9292:9292 mac798/ui:1.0
```

## задание со слайдов 17-18
* произведено уменьшение размера образа ui

## Задание со ( * ) {2}
* созданы новые версии образов ui и comment на основе alpine linux
* поскольку в alpine:latest используется ruby 2.5 необходимо изменить Gemfile для ui, установив версию haml ~> 5.0.4
* для уменьшения размера результирующего образа лучше скомпоновать все команды, выполняемые при создании образа в одну команду
* для избавления от "магии" команду `ADD` лучше заменить на `COPY` там, где она используется для копирования файлов
* итоговые размеры образов : comment - 53мб, ui - 61.4мб, post - 102мб

##

* запушен контейнер бд с подмонтированным томом, проверено, что данные остаются "на месте" после  перезагрузки контейнера

# дз №13 (docker-2)

* cоздан новый проект в gcloud
* настроена аутентификация gce sdk в новом проекте
* установлена и настроена docker-machine
* повторена практика из лекции с различными уровнями изоляции пространств имен
* в практическом задании с запуском образа tehbilly/htop хорошо видно, что
при запуске в изолированном пространстве имен процессов виден только один процесс --
сама программа htop. При запуске же этого образа с параметром `-pid host` в программе
htop видны все процессы, запущеннные на машине.
* По инструкциям со слайдов создан образ контейнера с установленными бд и сервером приложения
* Создан аккаунт на docker hub
* получившийся образ загружен на docker hub
## задание со ( * )
* создан сценарий ansible docker-install.yml, устанавливающий docker и запускающий службу
* создан сценарий packer, собирающий в gcloud образ ubuntu с установленным docker, используя сценарий ansible
* создана конфигурация terraform запускающая несколько (задается переменной) экземпляров вм с образом, созданном в предыдущем шаге
* создан динамический inventory.pl для ansible
* создан сценарий ansible run-docked-app.yml, который регистрирует и запускает модуль systemd, отвечающий за запуск контейнера docker с установленныс приложением

# дз №12 (docker-1)
* Воспроизведены шаги по интеграции репозитория с каналом slack
* добавлен шаблон описания для pull-request-ов
* добавлен .travis.yml
* воспроизведены шаги со слайлов 1-29 из домашнего задания

# mac798_microservices
mac798 microservices repository
