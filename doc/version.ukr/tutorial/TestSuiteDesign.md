# Оформлення тест сюіта

Описано структуру тест сюіта, підхід в використанні елементів.

### Загальна структура тест сюіта

На прикладі файла [`Join.test.js`](./HelloWorld.md) показано структуру тест сюіта.

<details>
    <summary><u>Код файла <code>Join.test.js</code></u></summary>

```js
let _ = require( 'wTesting' );
let Join = require( './Join.js' );

//

function routine1( test )
{
  test.identical( Join.join( 'Hello ', 'world!' ), 'Hello world!' );
}

//

function routine2( test )
{

  test.case = 'pass';
  test.identical( Join.join( 1, 3 ), '13' );

  test.case = 'fail';
  test.identical( Join.join( 1, 3 ), 13 );

}

//

var Self =
{
  name : 'Join',
  tests :
  {
    routine1,
    routine2,
  }
}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );
```

</details>

Приведений вище код має мінімальний набір даних для демонстрації структурних одиниць. Секціонування файлу за функціональним призначенням приведено на рисунку нижче.

<details>
    <summary><u>Структура тест файла на прикладі <code>Join.test.js</code></u></summary>

![join.test.png](../../images/join.test.png)

</details>

Структура тестового файла складається з чотирьох елементів:
- підключення залежностей;
- визначення тест рутин;
- визначення тест сюіта;
- секція запуску тест сюіта.

### Секція підключення залежностей

Секція призначена для підключення в тест файл залежностей потрібних для тестування. Для здійснення тестування обов'язковою є утиліта `Testing`. Інші залежності, що підключаються в файл підключають тест юніт і створюють оточення для виконання тесту.

В даному файлі підключено утиліту `Testing` і файл `Join.js` з рутиною для тестування.

Для встановлення залежностей використовується файл [`package.json`](./HelloWorld.md#Секція-підключення-залежностей). В файл записуються потрібні залежності, їх завантаження здійснюється командою `npm install` в директорії модуля.

### Секція визначення тест рутин

#### Тест рутини

Друга секція призначена для опису тестових рутин. Тест рутина - рутина ( функція, метод ) розроблена для тестування якогось із аспектів об'кту тестування. Тест рутина може включати:

- початкові дані, об'явлення контексту (за необхідності);
- [тест кейси](../concept/TestCase.md);
- [тест перевірки](../concept/TestCheck.md).

В приведеному коді, в рядках 7-23, приведено дві тест рутини. Перша, з назвою `routine1`, виконує одну тест перевірку на співпадіння отриманого і очікуваного значення. Друга тест рутина має назву `routine2` і включає два тест кейси - `pass` i `fail`.

Розробник може помістити в секцію необхідну кількість тест рутин для тестування обраного об'єкту. Кожна з тест рутин може містити довільну кількість тест кейсів і тест перевірок.

#### Тест кейси

Тест кейс - це одна або декілька тест перевірок із супровідним кодом поєднаних в логічну структурну одиницю для перевірки функціональності якогось аспекту об'єкту, що тестується.

Код тест кейсу в файлі `Join.test.s` має примітивну форму. Він складається з опису і тест перевірки. На практиці частіше зустрічаються тест кейси, що потребують об'явлення початкових даних і очікуваного результату тест кейсу.

<details>
    <summary><u>Приклад тест кейса з об'явленням змінних</u></summary>

```js
test.case = 'dst is empty array, ins is primitive';
var dst = [];
var ins = 'str';
var got = _.arrayAppend( dst, ins );
var expected = [ 'str' ];
test.identical( got, expected );
test.is( got === dst );
```

</details>

Використання змінних, в першу чергу, обумовлене потребами в якісному покритті. Приведений тест кейс показує, що рутина `arrayAppend` додає елемент `ins` в оригінальний `dst` масив, а не робить його копію. Також, використання змінних покращує сприйняття даних в тест кейсі за рахунок розділення на окремі складові.

Особливості написання тест кейсів і тест рутин описані в [туторіалі](./TestRoutineBasicTechnics.md).

#### Тест перевірки

Тест перевірки - очікування розробника стосовно поведінки об'єкту, що тестується виражене якоюсь умовою. Це найнижча структурна одиниця тестування.

Найчастіше тест перевірки є складовими тест кейсу, як показано в рутині `routine2` i тест кейсі зі зміннними. Часом виникає необхідність використати окрему тест перевірку без тест кейсу. Така тест перевірка може записуватись як в рутині `routine1`. В цьому випадку вона не має назви. Якщо перед окремою тест перевіркою є якийсь тест кейс, тоді в виводі тестера дана перевірка буде мати назву тест кейсу. Щоб відділити окрему тест перевірку використовується спеціальне поле `description`.

<details>
    <summary><u>Приклад об'явлення окремої тест перевірки</u></summary>

```js
test.description = 'not changed context routine';
test.identical( this.contextRoutine, onEach );
```

</details>

Приведена тест перевірка може розташовуватись між окремими групами тест кейсів. Вона перевіряє те, що проведені тести не змінили контекст виконання. Дана тест перевірка не загубиться серед виводу інших даних.

### Секція визначення тест сюіта

Секція призначенна для об'явлення тест сюіта - найвищої структурної одиниці тестування. Тест файл має містити лише один тест сюіт.

Для визначення тест сюіту він має містити назву і набір тест рутин.

Посилання на тест рутини поміщаються в секції `tests`. Порядок рутин в секції має відповідати порядку тест рутин в файлі. Це дозволяє швидко орієнтуватись в структурі файла і шукати потрібну тест рутину.

В об'явленні тест сюіта можуть міститись [додаткові опції](TestOptions.md), котрі керують процесом тестування. Також, в даній секції може міститись глобальний контекст виконання тест сюіту, спеціальні рутини, що виконуються перед початком тестування або після завершення тестування.

Згідно приведеного коду, файл `Join.test.js` містить тест сюіт `Join`. Тест сюіт має дві тест рутини. Тест сюіт не містить додаткових опцій.

<details>
    <summary><u>Приклад об'явлення тест сюіта з опціями і контекстом</u></summary>

```js
var Self =
{
  name : 'Join',
  silencing : 1,
  routineTimeOut : 30000,

  onSuiteBegin,
  onSuiteEnd,

  context :
  {
    assetFor
  },

  tests :
  {
    routine1,
    routine2,
  }
}
```

</details>

Приведена секція описує тест сюіт з назвою `Join`. Тест сюіт містить опції `silencing`, котра вимикає вивід об'єкту тестування, `routineTimeOut` - встановлює час на виконання окремої тест рутини. Поле `onSuiteBegin` вказує на спеціальну рутину, котра автоматично виконується перед запуском тестування тест рутин. Поле `onSuiteEnd` - відповідно на рутину, котра буде автоматично виконана після завершення тестування. Поле `context` визначає глобальний контекст тест сюіта. В даному випадку поле `context` містить посилання на рутину `assetFor`.

цДля зручності глобальний контекст і спеціальні рутини поміщаються на початку тест сюіта, одразу після підключення залежностей.

Для доступу до даних контексту в тест рутині використовується ключове слово `this`.

<details>
    <summary><u>Приклад використання рутини контексту</u></summary>

```js
function testRoutine( test )
{
  var asset = this.assetFor( test, 'testRoutine' );

  // code of test routine
}
```

</details>

Змінній `asset` призначено результат виконання рутини `assetFor` контексту.

### Cекція запуску тест сюіта

Рядки 39-41 містять функції для запуску тестування.
В 39-ому рядку відбувається створення тест сюіта. А в рядках 40-41 відбувається його запуск. Без рядків 40-41 тест файл буде неможливо запустити напряму: `node Join.test.js`.

### Підсумок

- Для зручності управління процесом тестування кожен тест сюіт має знаходитися у окремому файлі.
- Тест файл складається з чотирьох основних частин: підключення залежностей, визначення тест рутин, визначення тест сюіта, запуск тест сюіта.
- Основний код тест сюіта поміщається в секції тест рутин.
- Розробник визначає потрібну кількість тест рутин, тест кейсів і тест перевірок.
- Об'явлення тест сюіту має містити назву і набір тест рутин. Додатково можуть бути об'явлені опції тестування, контекст і рутини для підготовки і завершення виконання тест сюіта.

[Повернутись до змісту](../README.md#Туторіали)