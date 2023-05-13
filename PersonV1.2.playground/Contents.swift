import UIKit
// вспомогательный рандомайзер, так как я не нашла отдельнуюю функцию для генерации строк
func randomString(length: Int) -> String {
  let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  return String((0..<length).map{ _ in letters.randomElement()! })
}

struct Address {
    let city, streetName: String
    let buldingNumber: String // у тебя в условие было написано, номер улицы, я решила что это очепятка, поэтому написала номер дома
    let floor, apartment: String
}
class Person {
    let id: Int
    let firstName, lastName, age: String
    let address: Address
    init (id: Int, firstName: String, lastName: String, age: String, address: Address){
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.address = address
    }
}
class Generator {
    let N: Int
    init (N:Int){
        self.N = N
    }
    // дальше нужно психологически подготовиться к жести, так как я не смогла нагуглить нормальную реализацию алгоритма, в итоге пришлось в ручную каждому значению все подставлять
    
    func GenPersonality (){
       
        func GeneratedString (lenOfString:Int)-> String{ // функция которая задаёт вероятность пустого поля и заполняет строку
            let Probability = lenOfString // здесь реализуем вероятность 0,3 заполнения пустым значением,
            if Probability >= 7 {
                return ""
            }else{
                return randomString(length: lenOfString)
            }
        }
        
        var persons = [Person]()// определение пустого массива объектов Человек
        for i in 0...N-1{ // здесь я проставляю для каждой строки (кроме id) рандомное значение. Я бы хотела просто перебрать все свойства объекта и им проставть, но у меня не получилось найти как это сделать :(
            
            let generatedAddress = Address (city: GeneratedString(lenOfString: Int.random(in: 0...9)),streetName: GeneratedString(lenOfString: Int.random(in: 0...9)), buldingNumber: GeneratedString(lenOfString: Int.random(in: 0...9)), floor:GeneratedString(lenOfString: Int.random(in: 0...9)),apartment: GeneratedString(lenOfString: Int.random(in: 0...9)))
            
            let newPerson = Person(id: i, firstName: GeneratedString(lenOfString: Int.random(in: 0...9)), lastName: GeneratedString(lenOfString: Int.random(in: 0...9)), age: GeneratedString(lenOfString: Int.random(in: 0...9)), address: generatedAddress)
            // грамоздкая задача рандомных значений свойствам и создание нового класса
            persons.append(newPerson)// добавляем в массив объект
        }
     
        Pathfinder.find(findPersons:persons) // передаем массив в функцию
    }
}
class Pathfinder{
    
    // функция принимает массив из объектов Человек
    static func find (findPersons:[Person]) {
        var emptyField: [Int:String] = [:] // решила создать именно словарь для запоминания пустых значений
        var message = "" // в эту переменную сохраняются названия полей, которые будут выводиться
        
// дальше без просветный кошмар и ужас. Я не нашла как опять таки перебирать свойства, поэтому долго и муторно прописываю каждый. У меня была идея прокидывать условный параметр, который бы при каждой итерации менял бы свое значение, например person.label, где label принимало бы значение firstName, lastName и тд вроде есть такая штука как Перечесления но я не поняла как я могу её применить как хочу
        
        for person in findPersons {
//Поле Имя
            if person.firstName == ""{
                emptyField[person.id] = "Имя"
            }
            }
        for person in findPersons {
//Поле Фамилия
            if person.lastName == ""
            {
                if emptyField[person.id] != nil { // здесь я проверяю, были ли уже пустые поля у конкретного Человека
                    message.append(emptyField[person.id] ?? "") // добавляю в сообщение название предыдущего филда
                    message.append(", Фамилия") //добавляю в сообщение текущий филд
                    emptyField.updateValue(message, forKey: person.id)
                    message = ""
                } else {
                    emptyField[person.id] = "Фамилия"
                }
            }
//Поле Возраст
            if person.age == ""
            {
                if emptyField[person.id] != nil { // здесь я проверяю, были ли уже пустые поля у конкретного Человека
                    message.append(emptyField[person.id] ?? "") // добавляю в сообщение название предыдущего филда
                    message.append(", Возраст") //добавляю в сообщение текущий филд
                    emptyField.updateValue(message, forKey: person.id)
                    message = ""
                } else {
                    emptyField[person.id] = "Возраст"
                }
            }
//Поле Город
            if person.address.city == ""
            {
                if emptyField[person.id] != nil { // здесь я проверяю, были ли уже пустые поля у конкретного Человека
                    message.append(emptyField[person.id] ?? "") // добавляю в сообщение название предыдущего филда
                    message.append(", Город") //добавляю в сообщение текущий филд
                    emptyField.updateValue(message, forKey: person.id)
                    message = ""
                } else {
                    emptyField[person.id] = "Город"
                }
            }
            if person.address.streetName == ""
            {
                if emptyField[person.id] != nil { // здесь я проверяю, были ли уже пустые поля у конкретного Человека
                    message.append(emptyField[person.id] ?? "") // добавляю в сообщение название предыдущего филда
                    message.append(", Улица") //добавляю в сообщение текущий филд
                    emptyField.updateValue(message, forKey: person.id)
                    message = ""
                } else {
                    emptyField[person.id] = "Улица"
                }
            }
            if person.address.buldingNumber == ""
            {
                if emptyField[person.id] != nil { // здесь я проверяю, были ли уже пустые поля у конкретного Человека
                    message.append(emptyField[person.id] ?? "") // добавляю в сообщение название предыдущего филда
                    message.append(", Номер дома") //добавляю в сообщение текущий филд
                    emptyField.updateValue(message, forKey: person.id)
                    message = ""
                } else {
                    emptyField[person.id] = "Номер дома"
                }
            }
            if person.address.floor == ""
            {
                if emptyField[person.id] != nil { // здесь я проверяю, были ли уже пустые поля у конкретного Человека
                    message.append(emptyField[person.id] ?? "") // добавляю в сообщение название предыдущего филда
                    message.append(", Этаж") //добавляю в сообщение текущий филд
                    emptyField.updateValue(message, forKey: person.id)
                    message = ""
                } else {
                    emptyField[person.id] = "Этаж"
                }
            }
            if person.address.apartment == ""
            {
                if emptyField[person.id] != nil { // здесь я проверяю, были ли уже пустые поля у конкретного Человека
                    message.append(emptyField[person.id] ?? "") // добавляю в сообщение название предыдущего филда
                    message.append(", Квартира") //добавляю в сообщение текущий филд
                    emptyField.updateValue(message, forKey: person.id)
                    message = ""
                } else {
                    emptyField[person.id] = "Квартира"
                }
            }
            
        }
        
        
        
        for i in emptyField.keys {
            print("Экземпляр",i,"имеет пустые поля:", emptyField[i]! )
        }
        }
    
    }
    
var N = Generator(N: 100)
N.GenPersonality()

