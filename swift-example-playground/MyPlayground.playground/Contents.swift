import UIKit
import Foundation

// MARK: - 2장. 스위프트 처음 시작하기

// print문 테스트

struct BasicInformation {
    let name: String
    var age: Int
}

var yagomInfo: BasicInformation = BasicInformation(name: "이재현", age: 24)

class Person {
    var height: Float = 0.0
    var weight: Float = 0.0
}

let yagom: Person = Person()
yagom.height = 182.5
yagom.weight = 78.5

print(yagomInfo)
dump(yagomInfo)

var name: String = "이재현"
var job = "Student" // 타입 추론

// MARK: - 3장. 데이터 타입 기본

// Int와 UInt
// Int는 일반 정수, UInt는 양의 정수만 표현

var integer: Int = -100
let unsignedInteger: UInt = 50
print("integer 값: \(integer), unsignedInteger 값: \(unsignedInteger)")
print("Int 최대값: \(Int.max), Int 최소값: \(Int.min)")
print("UInt 최대값: \(UInt.max), UInt 최소값: \(UInt.min)")

// 진수별 정수 표현

let decimalInteger: Int = 28
let binaryInteger: Int = 0b11100    // 2진수
let octalInteger: Int = 0o34    // 8진수
let hexadecimalInteger: Int = 0x1C  // 16진수

// bool toggle

var boolean: Bool = true
boolean.toggle()

// Float과 Double

var floatValue: Float = 1234567890.1    // float은 표현할 수 있는 범위가 좁아 부정확
var doubleValue: Double = 1234567890.1  // double은 표현할 수 있는 범위가 넓어 정확

print("floatValue: \(floatValue), doubleValue: \(doubleValue)")

// Any와 AnyObject
// AnyObject는 Any보다 조금 한정된 의미, 클래스의 인스턴스만 할당 가능

var someVar: Any = "yagom"  // 어떤 타입의 값도 할당 가능
someVar = 50
someVar = 100.1

// MARK: - 4장. 데이터 타입 고급

// 타입 별칭

typealias MyInt = Int
typealias YourInt = Int
typealias MyDouble = Double

let age: MyInt = 100
var year: YourInt = 2080

// 튜플

var person: (String, Int, Double) = ("yagom", 100, 182.5)
print("이름: \(person.0), 나이: \(person.1), 신장: \(person.2)")  // 튜플에서 인덱스값을 통해 접근 가능

typealias PersonTuple = (name: String, age: Int, height: Double)    // 튜플도 타입 별칭이 ㄱ가능
let eric: PersonTuple = ("에릭", 150, 183.5)
print(eric)

// 컬렉션형: 배열, 딕셔너리, 세트
// 배열

var names: [String] = ["재현", "재영"]
var emptyArray: [Any] = [Any]()
print(emptyArray.isEmpty)

names.append("몽이")
print(names)
names.removeLast()
print(names)

// 딕셔너리

typealias StringIntDictionary = [String: Int]   // 타입 별칭으로 간단하게 표현도 가능
var numberForName: Dictionary<String, Int> = Dictionary<String, Int>()
numberForName = ["이재현": 100, "이재영": 150]
print(numberForName.count)
print(numberForName.removeValue(forKey: "이재현"))
print(numberForName)

// 세트

var namesSet: Set<String> = ["이재현", "이재영", "몽이", "이재현"]
print(namesSet.count)   // 중복된 값을 허용하지 않음

// 집합 연산
let englishClassStudent: Set<String> = ["이재현", "김종명"]
let koreanClassStudent: Set<String> = ["노수인", "심재민", "김종명"]

let intersectSet: Set<String> = englishClassStudent.intersection(koreanClassStudent)    // 교집합
let symmetricDiffSet: Set<String> = englishClassStudent.symmetricDifference(koreanClassStudent) // 여집합
let unionSet: Set<String> = englishClassStudent.union(koreanClassStudent)   // 합집합
let subtractSet: Set<String> = englishClassStudent.subtracting(koreanClassStudent)  // 차집합

print(unionSet.sorted())
print(unionSet.shuffled())  // 뒤죽박죽 ㅋ

// 열거형

enum School: String {
    case primary
    case elemnet
    case middle
    case high
}

var highestEducationLevel: School = School.primary

let primary = School(rawValue: "유치원")   // 원시 값 사용 가능

// 연관 값을 갖는 열거형

enum MainDish {
    case pasta(taste: String)
    case pizza(dough: String, topping: String)
    case chicken(withSauce: Bool)
    case rice
}

var dinner: MainDish = MainDish.pasta(taste: "크림")

// 항목 순회
// 열거형에 포함된 모든 케이스를 알아야 할 때, CaseIterable 프로토콜을 채택해 항목 순회

enum happy: CaseIterable {
    case candy
    case pasta
    case choco
    case mong
}

let allCases: [happy] = happy.allCases
print(allCases)

// 그렇지만 플랫폼별로 사용 조건을 추가하는 경우, allCases를 사용하지 못함
// 또한, 열거형의 케이스가 연관 값을 가지는 경우, allCase를 사용하지 못함

// 순환 열거형
// 열거형 항목의 연관 값이 열거형 자신의 값이고자 할 때 사용

enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let final = ArithmeticExpression.multiplication(five, four)

func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case .number(let value):
        return value
    case .addition(let left, let right):
        return evaluate(left) + evaluate(right)
    case .multiplication(let left, let right):
        return evaluate(left) * evaluate(right)
    }
}

let result: Int = evaluate(final)
print(result)

// 비교 가능한 열거형

enum Condition: Comparable {
    case terrible
    case bad
    case good
    case great
}

let myCondition: Condition = Condition.great
let yourCondition: Condition = Condition.bad

if myCondition >= yourCondition {
    print("제 상태가 더 좋군요")
} else {
    print("당신의 상태가 더 좋아요")
}

// MARK: - 5장. 연산자

// 산술 연산자

let number: Double = 5.0
var operatorResult: Double = number.truncatingRemainder(dividingBy: 1.5)
operatorResult = 12.truncatingRemainder(dividingBy: 2.5)

// 삼항 조건 연산자

var valueA: Int = 3
var valueB: Int = 5
var biggerValue: Int = valueA > valueB ? valueA : valueB

valueA = 0
valueB = -3
biggerValue = valueA > valueB ? valueA : valueB

var stringA: String = ""
var stringB: String = "String"
var resultValue: Double = stringA.isEmpty ? 1.0 : 0.0
resultValue = stringB.isEmpty ? 1.0 : 0.0

// 오버플로 연산자
// 기존 프로그래밍 언어에서 오버플로 가능 연산을 따로 로직을 설계해야 했던 것에 비해
// 스위프트에서는 기본 연산자를 통해 따로 처리 없이 이를 가능케 함

var unsignedInteger8: UInt8 = 0
let underflowedValue: UInt8 = unsignedInteger8 &- 1     // 255로 출력

// 사용자 정의 연산자
// 스위프트에서는 사용자의 입맛대로 연산자를 만들고 역할을 부여할 수 있음


// 전위 연산자
prefix operator **

prefix func ** (value: Int) -> Int {
    return value * value
}

let minusFive: Int = -5
let sqrtMinusFive: Int = **minusFive

// 후위 연산자
postfix operator **

postfix func ** (value: Int) -> Int {
    return value + 10
}

let sqrtFivePlusTen: Int = **minusFive**
print(sqrtFivePlusTen)

// 중위 연산자
// precedencegroup으로 연산자 우선 순위를 정해줄 수 있음

infix operator ** : MultiplicationPrecedence

func ** (lhs: String, rhs: String) -> Bool {
    return lhs.contains(rhs)
}

let helloYagom: String = "Hello jaehyun"
let jaehyun: String = "jaehyun"
let isContainsYagom: Bool = helloYagom ** jaehyun

// 클래스 및 구조체의 비교 연산자 구현

class Car {
    var modelYear: Int?
    var modelName: String?
}

struct SmartPhone {
    var company: String?
    var model: String?
}

func == (lhs: Car, rhs: Car) -> Bool {
    return lhs.modelName == rhs.modelName
}

func == (lhs: SmartPhone, rhs: SmartPhone) -> Bool {
    return lhs.model == rhs.model
}

let myCar = Car()
myCar.modelName = "S"

let yourCar = Car()
yourCar.modelName = "S"

var myPhone = SmartPhone()
myPhone.model = "SE"

var yourPhone = SmartPhone()
yourPhone.model = "6"

print(myCar == yourCar)
print(myPhone == yourPhone)

// MARK: - 6장. 흐름 제어

// if 구문

let first: Int = 5
let second: Int = 7

if first > second {
    print("first > second")
} else if first < second {
    print("first < second")
} else {
    print("first == second")
}

var biggerValueIf: Int = 0

if first > second {
    biggerValueIf = first
} else if first == second {
    biggerValueIf = second
} else if first < second {
    biggerValueIf = second
}   // 마지막 else 생략 가능

print(biggerValueIf)

// switch 구문

let integerValue: Int = 5

switch integerValue {
case 0:
    print("Value == zero")
case 1...10:    // case문에 범위를 넣을 수도 있음 (!!)
    print("Value == 1~10")
    fallthrough
case Int.min..<0, 101..<Int.max:
    print("Value < 0 or Value > 100")
    break
default:
    print("10 < value <= 100")
}

let stringValue: String = "Liam Neeson"

switch stringValue {
case "yagom":
    print("He is yagom")
case "Jay":
    print("He is Jay")
case "Jenny", "Joker", "Nova":
    print("He or She is \(stringValue)")
default:
    print("\(stringValue) said 'I don't know who you are'")
}

// 튜플 switch case 구성

typealias NameAge = (name: String, age: Int)

let tupleValue: NameAge = ("yagom", 99)

switch tupleValue {
case ("yagom", 99):
    print("정확히 맞췄습니다!")
case ("yagom", _):
    print("이름만 맞았습니다. 나이는 \(tupleValue.age) 입니다.")
case (_, 99):
    print("나이만 맞았습니다. 이름은 \(tupleValue.name) 입니다.")
default:
    print("누굴 찾나요?")
}

// where를 사용하여 switch case 확장

let 직급: String = "사원"
let 연차: Int = 1
let 인턴인가: Bool = false

switch 직급 {
case "사원" where 인턴인가 == true:
    print("인턴입니다.")
case "사원" where 연차 < 2 && 인턴인가 == false:
    print("신입사원입니다.")
case "사원" where 연차 > 5:
    print("연식 좀 된 사원입니다.")
case "사원":
    print("사원입니다.")
case "대리":
    print("대리입니다.")
default:
    print("사장입니까?")
}

enum Menu {
    case chicken
    case pizza
    case hamburger
}

let lunchMenu: Menu = .chicken

switch lunchMenu {
case .chicken:
    print("바ㄴ반무많이")
case .pizza:
    print("핫소스 많이 주세요")
case .hamburger:
    print("햄버거 맛있겟다")
@unknown case _:    // default와 같은 역할이지만, case가 추가될 것을 고려한 와일드카드, unknown 속성을 이용해 논리적 오류를 방지
    print("오늘 메뉴가 뭐죠?")
}

// for-in 구문

for i in 0...2 {
    print(i)
}

for i in 0...5 {
    if i.isMultiple(of: 2) {
        print(i)
        continue
    }
    
    print("\(i) == 홀수")
}

let helloSwift: String = "Hello Swift!"

for char in helloSwift {
    print(char)
}

var forInResult: Int = 1

// 시퀀스에 해당하는 값이 필요가 없다면 와일드카드를 써도 가능

for _ in 1...3 {
    forInResult *= 10
}

print(forInResult)

var friends: [String: Int] = ["김종명": 26, "노수인": 25, "심재민": 25]

for tuple in friends {
    print(tuple)
}

// while 반복 구문의 활용

while names.isEmpty == false {
    print("Good bye \(names.removeFirst())")
}

var numbers: [Int] = [3, 2, 23423, 12312]

numbersLoop: for num in numbers {
    if num > 5 || num < 1 {
        continue numbersLoop
    }
    
    var count: Int = 0
    
printLoop: while true {
    print(num)
    count += 1

    if count == num{
        break printLoop
    }
}
    
removeLoop: while true {
    if numbers.first != num {
        break numbersLoop
    }
    
    numbers.removeFirst()
}
}

// MARK: - 7장. 함수

// 기본 형태의 함수
func hello(name: String) -> String {
    return "Hello \(name)!"
}

let helloJenny: String = hello(name: "Jenny")
print(helloJenny)

func introduce(name: String) -> String {
    "제 이름은 " + name + "입니다."
}

let introcudeJenny: String = introduce(name: "Jenny")
print(introcudeJenny)

// 전달인자 레이블이 없는 함수

func sayHello(_ name: String, _ times: Int) -> String {
    var result: String = ""
    
    for _ in 0..<times {
        result += "Hello \(name)!" + " "
    }
    
    return result
}

print(sayHello("종명", 2))

// inout 매개변수의 활용

func nonReferenceParameter(_ arr: [Int]) {
    var copiedArr: [Int] = arr
    copiedArr[1] = 1
}

func referenceParameter(_ arr: inout [Int]) {
    arr[1] = 1
}

nonReferenceParameter(numbers)
print(numbers[1])

referenceParameter(&numbers)
print(numbers[1])

// 반환값이 없는 함수

func sayGoodBye() -> Void {
    print("안녕~~")
}

sayGoodBye()

// 함수 타입의 활용
// 함수를 전달인자로 받을 수도, 반환값으로 돌려줄 수도 있음

typealias CalculateTwoInts = (Int, Int) -> Int

func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}

func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}

var mathFunction: CalculateTwoInts = addTwoInts
print(mathFunction(2, 5))

mathFunction = multiplyTwoInts
print(mathFunction(2, 5))

// 전달인자로 함수를 전달받는 함수

func printMathResult(_ mathFunction: CalculateTwoInts, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}

printMathResult(addTwoInts, 3, 5)

// 중첩 함수의 사용: 재귀함수 st??

typealias MoveFunc = (Int) -> Int

func functionForMove(_ shouldGoLeft: Bool) -> MoveFunc {
    func goRight(_ currentPosition: Int) -> Int {
        return currentPosition + 1
    }
    
    func goLeft(_ currentPosition: Int) -> Int {
        return currentPosition - 1
    }
    
    return shouldGoLeft ? goLeft : goRight
}

var position: Int = -4

// 종료되지 않는 함수
// 정상적으로 끝나지 않았다는 뜻으로, 비반환 메서드라고도 부름
// 대표적인 예로는 fatalError 함수
// Never를 반환 타입으로 명시해주면 됨

func crashAndBurn() -> Never {
    fatalError("Something very, very bad happened")
}

func someFunction(isAllIsWell: Bool) {
    guard isAllIsWell else {
        print("마을에 도둑이 들었습니다!")
        crashAndBurn()
    }
    print("All is well")
}

someFunction(isAllIsWell: true)
//someFunction(isAllIsWell: false)

// 반환 값을 무시할 수 있는 함수
// 가끔 함수의 반환값이 필요 없을 수도 잇자나 ?
// 일반적으로 반환값을 사용하지 않으면 컴파일러가 경고를 보내는데,
// @discardableResult를 선언하면 경고가 안 뜸 ㅋ

@discardableResult
func say(_ something: String) -> String {
    print(something)
    return something
}

say("hello")
