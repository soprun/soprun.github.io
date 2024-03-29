---
title: Books 📚
description: Книги по архитектуре, шаблонам программирования и многое другое...
permalink: /books
image: https://images.unsplash.com/photo-1497633762265-9d179a990aa6
published: false
---

- [Эволюционная архитектура. Поддержка непрерывных изменений (Н.Форд, Р.Парсонс, П.Куа, 2019) .PDF](https://drive.google.com/file/d/1wrxpxM0A2rOxthLGA-DRExCXuYzNbqDU/view?usp=sharing)
- [Introduction to Solution Architecture (Alan McSweeney, 2019) .PDF](https://drive.google.com/file/d/1n9B1qxWRaC53ECs6IGRPNSfai2YSaruk/view?usp=sharing)

> Если вы не можете построить монолитную архитектуру, то почему вы считаете, что микросервисы будут решением?
> -- Саймон Браун (Simon Brown)

> Старайтесь до конца понять по крайней мере один уровень абстракции, находящийся ниже того уровня, на котором вы обычно работаете.
> -- Мудрецы программного обеспечения

---

**Принудительное уменьшение связанности**
Одной из целей архитектуры микросервисов является сильное уменьшение связанности технической архитектуры, что позволяет
заменять сервис без побочных эффектов. Однако если все разработчики совместно используют один и тот же код или даже
платформу, отсутствие связанности требует от разработчиков некоторой дисциплины (поскольку велико искушение повторного
использования существующего кода) и средств защиты, чтобы гарантировать, что связанность не возникнет случайно.
Построение сервисов в различных технологических стеках является одним из способов достижения несвязанности технической
архитектуры. Многие компании стараются избегать использования этого метода, так как опасаются, что он будет
препятствовать перемещению персонала по проектам. Однако Чед Фаулер1 (Chad Fowler), разработчик компании Wunderlist,
попробовал применить противоположный подход: он настоял на том, чтобы команды использовали другие технологические стеки
для исключения несоответствующей связанности. Его принцип состоит в том, что возникающая случайно связанность является
большей проблемой, чем мобильность разработчика.
Многие компании инкапсулируют отдельную функциональность в платформу как услугу1 для внутреннего применения, скрывая
выборы технологии (и тем самым возможности связанности) за хорошо определенный интерфейс.

---

**Обнаружение новых ресурсов путем автоматизации devops**
Однажды Нил консультировал компанию, которая предлагала услуги внешнего размещения. В компании работала дюжина команд
разработки, все с хорошо определенными модулями. У них была оперативная группа, которая управляла всем обслуживанием,
инициализацией, мониторингом и другими задачами общего назначения. Менеджер обычно получал жалобы от разработчиков,
которые хотели бы ускорить оборот необходимых ресурсов, таких как база данных и веб-серверы. Чтобы хоть как-то снизить
давление, он стал назначать оперативного сотрудника один день в неделю для каждого проекта. В этот день разработчики
были счастливы, поскольку могли не дожидаться ресурсов! Увы, у менеджера не было достаточно ресурсов, чтобы делать это
регулярно.
Или он так считал. Мы обнаружили, что большая часть ручной работы, выполняемой операциями, была сложной случайно:
неправильно сконфигурированные машины, хаос из производителей и брендов и много других поправимых нарушений. После того
как все было надлежащим образом каталогизировано, мы помогли этой компании автоматизировать инициализацию новых машин,
используя ситему Puppet (<https://puppet.com>). После этой работы оперативная группа имела достаточно сотрудников, чтобы
постоянно внедрять инженера по эксплуатации в каждый проект и все еще иметь достаточно людей для управления
автоматизированной инфраструктурой.
Им не пришлось нанимать новых инженеров, а также менять роли. Вместо этого они воспользовались современной практикой
проектирования для автоматизации всего того, чем не должен заниматься человек, освободив сотрудников для лучшего
применения усилий в разработке.
