//
//  NetworkManager.swift
//  VK
//
//  Created by пользовтель on 20.04.2021.
//

import Foundation
import Alamofire

class VKService {
    // базовый URL сервиса
        let baseUrl = "https://api.vk.com"
        // ключ для доступа к сервису
        let apiKey = Session.shared.token
        
        // метод для загрузки данных, в качестве аргументов получает город
        func loadData(getData: String){
            
        // путь для получения погоды за 5 дней
            let path = "/method/"
        // параметры, город, единицы измерения градусы, ключ для доступа к сервису
            let methodName: Parameters = [
                "": getData,
                "access_token": apiKey,
                "v": "5.130"
            ]
            
        // составляем URL из базового адреса сервиса и конкретного пути к ресурсу
            let url = baseUrl+path
            
        // делаем запрос
            AF.request(url, method: .get, parameters: methodName).responseJSON { repsonse in
                print(repsonse.value)
            }
            
        }
}
