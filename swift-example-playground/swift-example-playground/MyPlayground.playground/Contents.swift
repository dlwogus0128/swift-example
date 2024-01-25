import UIKit

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
