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
   
        // метод для загрузки данных, в качестве аргументов получает вид запроса
        func loadData(getData: String){
            
        // путь для получения списков друзей или груп
            let path = "/method/" + getData
        // параметры, токен, версия
            let methodName: Parameters = [
                "access_token": apiKey,
                "v": "5.130"
            ]
            
        // составляем URL из базового адреса сервиса и конкретного пути к ресурсу
            let url = baseUrl+path
            
        // делаем запрос
            AF.request(url, method: .get, parameters: methodName).responseJSON { response in
                print(response.value ?? "")
            }
            
        }
    func loadUserData(data: String, userId: String){
            
        // путь для получения к пользователяи
            let path = "/method/" + data
        // параметры, айди соответсвующего пользователя, др, токен и версия
            let methodName: Parameters = [
                "user_ids": userId,
                "fields": "bdate",
                "access_token": apiKey,
                "v": "5.130"
            ]
            
        // составляем URL из базового адреса сервиса и конкретного пути к ресурсу
            let url = baseUrl+path
            
        // делаем запрос
            AF.request(url, method: .get, parameters: methodName).responseJSON { response in
                print(response.value ?? "")
            }
        
    }
    func loadPhotoData(userId: String){
            
        // путь для получения к пользователяи
            let path = "/method/photos.get"
        // параметры, айди соответсвующего пользователя, др, токен и версия
            let methodName: Parameters = [
                "owner_id": userId,
                "album_id": "wall",
                "access_token": apiKey,
                "v": "5.130"
            ]
            
        // составляем URL из базового адреса сервиса и конкретного пути к ресурсу
            let url = baseUrl+path
            
        // делаем запрос
            AF.request(url, method: .get, parameters: methodName).responseJSON { response in
                print(response.value ?? "")
            }
        
    }
    func searchGroups(searchField: String){
            
        // путь для получения к пользователяи
            let path = "/method/groups.search"
        // параметры, айди соответсвующего пользователя, др, токен и версия
            let methodName: Parameters = [
                "q": searchField,
                "count": "3",
                "access_token": apiKey,
                "v": "5.130"
            ]
            
        // составляем URL из базового адреса сервиса и конкретного пути к ресурсу
            let url = baseUrl+path
            
        // делаем запрос
            AF.request(url, method: .get, parameters: methodName).responseJSON { response in
                print(response.value ?? "")
            }
        
    }
}
