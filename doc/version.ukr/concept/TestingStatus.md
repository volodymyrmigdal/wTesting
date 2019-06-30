# Помилка тестування

Подія чи умова, яка призвела до провалу тестування.

### Види помилок тестування

- помилка коду об'єкта тестування;
- помилка коду тест сюіта;
- вихід процесу тестування за встановлені в [опціях тестування](../tutorial/Help.md#Опції-запуску-та-опції-сюіта) межі, наприклад, перевищення часу виконання рутини;
- непередбачувана поведінка об'єкта тестування, що призвела до дострокового завершення тестування;
- некоректне використання утиліти, що призвела до дострокового завершення тестування;
- дострокове завершення тестування ініційоване користувачем.

# Пройдене тестування

Результат виконання тестування, котрий не містить помилок тестування.

Передбачається, що проведене тестування містить лише успішно пройдені тести, з урахуванням обмежень встановлених в опціях тестування. При тестуванні скопом кожен тест сюіт має бути успішно пройденим.

# Провалене тестування

Результат виконання тестування, котрий містить принаймні одну помилку тестування. 

При тестуванні скопом одного проваленого тесту в окремому тест сюіті достатньо, щоб загальний результат вважався 'провалений'. 