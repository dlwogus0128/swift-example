import SwiftUI
import PlaygroundSupport

struct ExampleView: View {
    @State private var rotation: Double = 0
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.blue)
                .frame(width: 200, height: 200)
                .rotationEffect(.degrees(rotation))
                .animation(.linear(duration: 2), value: rotation)
            Button(action: {
                rotation = (rotation < 360 ? rotation + 60 : 0)
            }) {
                Text("Rotate")
            }
        }
        .padding(10)
    }
}

PlaygroundPage.current.setLiveView(ExampleView()
    .padding(100))

// propertyWrapper 예제

struct Address {
    private var cityname: String = ""
    
    var city: String {
        get { cityname }
        set { cityname = newValue.uppercased() }
    }
}

@propertyWrapper
struct FixCase {
    private(set) var value: String = ""
    
    var wrappedValue: String {
        get { value }
        set { value = newValue.uppercased()}
    }
    
    init(wrappedValue initialValue: String) {
        self.wrappedValue = initialValue
    }
}

struct Contact {
    @FixCase var name: String
    @FixCase var city: String
    @FixCase var country: String
}

var contact = Contact(name: "John Smith", city: "London", country: "United Kindom")
print("\(contact.name), \(contact.city), \(contact.country)")

// 여러 변수와 타입 지원하기

@propertyWrapper
struct MinMaxVal {
    var value: Int
    let max: Int
    let min: Int
    
    init(wrappedValue: Int, max: Int, min: Int) {
        value = wrappedValue
        self.max = max
        self.min = min
    }
    
    // 값이 특정 범위 안에 있는지 검사해야 함
    var wrappedValue: Int {
        get { return value }
        set {
            if newValue > max {
                value = max
            } else if newValue < min {
                value = min
            } else {
                value = newValue
            }
        }
    }
}

struct Demo {
    @MinMaxVal(max: 200, min: 100) var value: Int = 100
}

var demo = Demo()
demo.value = 150
print(demo.value)

demo.value = 250
print(demo.value)

// Comparable 프로토콜 채택

@propertyWrapper
struct MinMaxValCom<V: Comparable> {
    var value: V
    let max: V
    let min: V
    
    init(wrappedValue: V, max: V, min: V) {
        value = wrappedValue
        self.max = max
        self.min = min
    }
    
    var wrappedValue: V {
        get { return value }
        set {
            if newValue > max {
                value = max
            } else if newValue < min {
                value = min
            } else {
                value = newValue
            }
        }
    }
}

struct ComDemo {
    @MinMaxValCom(max: "Orange", min: "Apple") var value: String = ""
}

var comDemo = ComDemo()
comDemo.value = "Banana"
print(comDemo.value)

comDemo.value = "Zibra"
print(comDemo.value)

struct DateDemo {
    @MinMaxValCom(max: Calendar.current.date(byAdding: .month, value: 1, to: Date())!, min: Date()) var value: Date = Date()
}

var dateDemo = DateDemo()
print(dateDemo.value)

dateDemo.value = Calendar.current.date(byAdding: .day, value: 10, to: Date())!
print(dateDemo.value)

dateDemo.value = Calendar.current.date(byAdding: .month, value: 2, to: Date())!
print(dateDemo.value)
