## "GR-Refactoring-Kata"

Данный проект представляет собой решение задачи "GildedRose Refactoring Kata".
(Рефакторинг части кода системы управления запасами для вымышленного магазина при гостинице Gilded Rose).

Выполнено на языке Ruby, с использованием объектно-ориентированного подхода.

### Требования

Чтобы запустить этот проект, вам необходимо установить Ruby 3.1.1. 
Кроме того, проект использует библиотеку RSpec для запуска тестов.

### Установка

1. Перенесите содержимое данного репозитория на свой компьютер:

```
$ git clone git@github.com:axmaxon/gr-kata-2.git
```

2. Перейдите в каталог проекта:

```
$ cd gr-kata-2
```

3. Установите зависимости, указанные в Gemfile:

```
$ bundle install
```

### Запуск тестов

Для запуска тестов выполните следующую команду:

```
$ rspec
```

### Запуск демонстрационного мини-приложения

В корне проекта находится файл `demo.rb`, который демонстрирует работу системы в части ежедневного изменения качества товара.
Данное мини-приложение создает образец списка элементов, в нём также имитируется течение времени 
(2 дня - по умолчанию, или количество дней указанных пользователем), "в конце каждого дня"  ко всем товарам применяется их
#update_quality метод. Далее - в консоли пользователю предоставляется информация об изменении свойств товара для кажого дня.

Чтобы запустить демонстрацию обновления свойств товаров выполните следующую команду (в качестве необязательного аргумента можно 
передать количество дней):

```
$ ruby demo.rb <количество дней>
```
