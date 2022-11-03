//
//  LoginView.swift
//  FirestoreHypixel
//
//  Created by Tom Miller on 04/08/2022.
//

import SwiftUI

import FirebaseFirestore

struct LoginView: View {
    
    @State private var users : [SavedPlayer] = UserDefaults.getUsers() ?? [SavedPlayer]()
    
//    @AppStorage("recentUser") var user = ""
//    @AppStorage("recentUUID") var uuid = ""
    @FocusState private var usernameFocused : Bool
    @ObservedObject var vm : PlayerViewModel
    @State private var username = ""
    @State private var profileLoaded = false
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("recentPlayersOn") private var recentPlayersOn = true
    @State private var settingsOn = false
    @Environment(\.colorScheme) var colorScheme
    
    private var searchAllowed : Bool{
        if(username.count>2)
        {
            return false
        }
        return true
    }
    
    
    var body: some View {
        GeometryReader{ geo in
            HStack{
                
                //only have toggle on if settingson is true ig.
                if settingsOn{
                    SlideView(darkModeOn: $isDarkMode, settingsOn: $settingsOn, recentPlayersOn: $recentPlayersOn)
                        .frame(width: settingsOn ? geo.size.width * 0.55 : 0)
                }
                if #available(iOS 16.0, *) {
                    NavigationStack{
                        ZStack{ //why is this a ZStack?
                            Rectangle()
                                .fill(colorScheme == .dark ? Color.black : Color.white)
                                .ignoresSafeArea()
                            VStack{
                                
                                Text("Enter Your Username:")
                                    .font(.title.bold())
                                
                                
                                TextField("Username", text: $username)
                                    .frame(width: 280)
                                    .padding(.bottom)
                                    .focused($usernameFocused)
                                
                                
                                Button{
                                    usernameFocused = false //turning keyboard off(taking the focus off of it)
                                    
                                    Task{
                                        
                                        
                                        await vm.getPlayer(username: username)
                                        switch vm.state{
                                        case .success(var player):
                                            let docRef = vm.db.collection("players").document(player.displayname)
                                            docRef.getDocument {document, error in
                                                if let document = document, document.exists {
                                                    
                                                    
                                                    print("document exists")
                                                    player.todayFinalKills = document["todayFinalKills"] as? Int
                                                    player.todayFinalDeaths = document["todayFinalDeaths"] as? Int
                                                    player.todayBedwarsWins = document["todayBedwarsWins"] as? Int
                                                    player.todayBedwarsLosses = document["todayBedwarsLosses"] as? Int
                                                    player.todayTntRunWins = document["todayTntRunWins"] as? Int
                                                    player.todayTntRunLosses = document["todayTntRunLosses"] as? Int
                                                    player.todaySkywarsKills = document["todaySkyWarsKills"] as? Int
                                                    player.todaySkywarsDeaths = document["todaySkyWarsDeaths"] as?  Int
                                                    player.todaySkyWarsWins = document["todaySkyWarsWins"] as? Int
                                                    player.todaySkyWarsLosses = document["todaySkyWarsLosses"] as? Int
                                                    player.todayDuelWins = document["todayDuelsWins"] as? Int
                                                    player.todayDuelLosses = document["todayDuelsLosses"] as? Int
                                                    player.todayBridgeWins = document["todayBridgeWins"] as? Int
                                                    player.todayBridgeLosses = document["todayBridgeLosses"] as? Int
                                                    let registerDate = (document["registerDate"] as? Timestamp)?.dateValue() ?? Date()
                                                    let components = Calendar.current.dateComponents([.minute, .hour], from: registerDate , to: Date.now)
                                                    
                                                    player.hoursAway = 23 - (components.hour ?? 0)
                                                    player.minutesAway = 60 - (components.minute ?? 0)
                                                    
                                                    
                                                    vm.state = .success(data: player)
                                                    
                                                    
                                                }
                                                else{
                                                    //its new
                                                    let stats : [String : Int] = [
                                                        
                                                        "todayFinalKills": player.stats.Bedwars?.final_kills_bedwars ?? 0,
                                                        "todayFinalDeaths" : player.stats.Bedwars?.final_deaths_bedwars ?? 0,
                                                        "todayBedwarsWins" : player.stats.Bedwars?.wins_bedwars ?? 0,
                                                        "todayBedwarsLosses" : player.stats.Bedwars?.losses_bedwars ?? 0,
                                                        "todayTntRunLosses" : player.stats.TNTGames?.deaths_tntrun ?? 0,
                                                        "todayTntRunWins" : player.achievements?.tntgames_tnt_run_wins ?? 0,
                                                        "todaySkyWarsKills" : player.stats.SkyWars?.kills ?? 0,
                                                        "todaySkyWarsDeaths" : player.stats.SkyWars?.deaths ?? 0,
                                                        "todaySkyWarsWins" : player.stats.SkyWars?.wins ?? 0,
                                                        "todaySkyWarsLosses" : player.stats.SkyWars?.losses ?? 0,
                                                        "todayDuelsWins" : player.stats.Duels?.wins ?? 0,
                                                        "todayDuelsLosses" : player.stats.Duels?.losses ?? 0,
                                                        "todayBridgeLosses" : player.stats.Duels?.bridgeOverallLosses ?? 0,
                                                        "todayBridgeWins" : player.stats.Duels?.bridgeOverallWins ?? 0,
                                                        
                                                        
                                                        
                                                        
                                                        
                                                    ]
                                                    vm.db.newPlayerDocument(data: stats, username: player.displayname, uuid: player.uuid)
                                                    let docRef = vm.db.collection("players").document(player.displayname)
                                                    docRef.getDocument {document, error in
                                                        if let document = document, document.exists {
                                                            
                                                            
                                                            print("document exists")
                                                            player.todayFinalKills = document["todayFinalKills"] as? Int
                                                            player.todayFinalDeaths = document["todayFinalDeaths"] as? Int
                                                            player.todayBedwarsWins = document["todayBedwarsWins"] as? Int
                                                            player.todayBedwarsLosses = document["todayBedwarsLosses"] as? Int
                                                            player.todayTntRunWins = document["todayTntRunWins"] as? Int
                                                            player.todayTntRunLosses = document["todayTntRunLosses"] as? Int
                                                            player.todaySkywarsKills = document["todaySkyWarsKills"] as? Int
                                                            player.todaySkywarsDeaths = document["todaySkyWarsDeaths"] as?  Int
                                                            player.todaySkyWarsWins = document["todaySkyWarsWins"] as? Int
                                                            player.todaySkyWarsLosses = document["todaySkyWarsLosses"] as? Int
                                                            player.todayDuelWins = document["todayDuelsWins"] as? Int
                                                            player.todayDuelLosses = document["todayDuelsLosses"] as? Int
                                                            player.todayBridgeWins = document["todayBridgeWins"] as? Int
                                                            player.todayBridgeLosses = document["todayBridgeLosses"] as? Int
                                                            let registerDate = (document["registerDate"] as? Timestamp)?.dateValue() ?? Date()
                                                            let components = Calendar.current.dateComponents([.minute, .hour], from: registerDate , to: Date.now)
                                                            
                                                            player.hoursAway = 23 - (components.hour ?? 0)
                                                            player.minutesAway = 60 - (components.minute ?? 0)
                                                            
                                                            
                                                            vm.state = .success(data: player)
                                                            
                                                            
                                                        }
                                                    }
                                                }
                                            }
                                            let newUser = SavedPlayer(displayName: player.displayname, uuid: player.uuid, rankColor: player.rankPlusColor ?? "BLACK", rank: player.newPackageRank ?? "", mvpPlusPlus: player.monthlyPackageRank == "SUPERSTAR" ? true : false)
                                            var duplicate = false
                                            for user in users{
                                                if user.uuid == newUser.uuid{
                                                    duplicate = true
                                                }
                                            }
                                            
                                            if(!duplicate && users.count == 3){
                                                let tempUser = users[0]
                                                users[0] = newUser
                                                let tempUserTwo = users[1]
                                                users[1] = tempUser
                                                users[2] = tempUserTwo
                                                
                                            }
                                            else if(!duplicate){
                                                users.append(SavedPlayer(displayName: player.displayname, uuid: player.uuid, rankColor: player.rankPlusColor ?? "BLACK", rank: player.newPackageRank ?? "", mvpPlusPlus: player.monthlyPackageRank == "SUPERSTAR" ? true : false))
                                            }
                                            
                                            let encoder = JSONEncoder()
                                            if let data = try? encoder.encode(users){
                                                UserDefaults.standard.set(data, forKey: "users")
                                            }
                                            profileLoaded = true
                                        default:
                                            print("default")
                                        }
                                        
                                        
                                        
                                    }
                                } label:
                                {
                                    
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 5)
                                            .fill(isDarkMode  ? Color(red: 214/255, green: 15/255, blue: 81/255) : .gray)
                                            .frame(width: 200, height: 50)
                                        
                                        Text("Search")
                                            .foregroundColor(.white)
                                        
                                        
                                        
                                    }
                                }
                                
                                
                                //we need to check if the vm.state enum is in the .failed type
                                
                                //very very replacable
                                switch vm.state{
                                case .failed(let error):
                                    if(error.localizedDescription=="The Internet connection appears to be offline."){
                                        Text("Your internet appears to be offline.")
                                            .foregroundColor(.red)
                                    }
                                    else{
                                        Text("Something went wrong, please try again.")
                                            .foregroundColor(.red)
                                    }
                                    
                                default:
                                    EmptyView()
                                }
                                //super replaceable
                                
                                //list of recent players
                                
                                
                                // VSTACK GOES HERE.
                                if recentPlayersOn{
                                    VStack(alignment: .leading){
                                        Text("Recent Users:")
                                            .font(.body.bold())
                                            .padding(.horizontal, 15)
                                        ForEach(users, id: \.uuid) { user in
                                            Button{
                                                Task{
                                                    await vm.getPlayer(username: "\(user.displayName)")
                                                    switch vm.state{
                                                    case .success(var player):
                                                        let docRef = vm.db.collection("players").document(player.displayname)
                                                        docRef.getDocument {document, error in
                                                            if let document = document, document.exists {
                                                                
                                                                
                                                                print("document exists")
                                                                player.todayFinalKills = document["todayFinalKills"] as? Int
                                                                player.todayFinalDeaths = document["todayFinalDeaths"] as? Int
                                                                player.todayBedwarsWins = document["todayBedwarsWins"] as? Int
                                                                player.todayBedwarsLosses = document["todayBedwarsLosses"] as? Int
                                                                player.todayTntRunWins = document["todayTntRunWins"] as? Int
                                                                player.todayTntRunLosses = document["todayTntRunLosses"] as? Int
                                                                player.todaySkywarsKills = document["todaySkyWarsKills"] as? Int
                                                                player.todaySkywarsDeaths = document["todaySkyWarsDeaths"] as?  Int
                                                                player.todaySkyWarsWins = document["todaySkyWarsWins"] as? Int
                                                                player.todaySkyWarsLosses = document["todaySkyWarsLosses"] as? Int
                                                                player.todayDuelWins = document["todayDuelsWins"] as? Int
                                                                player.todayDuelLosses = document["todayDuelsLosses"] as? Int
                                                                player.todayBridgeWins = document["todayBridgeWins"] as? Int
                                                                player.todayBridgeLosses = document["todayBridgeLosses"] as? Int
                                                                let registerDate = (document["registerDate"] as? Timestamp)?.dateValue() ?? Date()
                                                                let components = Calendar.current.dateComponents([.minute, .hour], from: registerDate , to: Date.now)
                                                                print("difference is \(components.hour ?? 0) hours and \(components.minute ?? 0) minutes.")
                                                                print("resets in \(23 - (components.hour ?? 0))hours and \(60 - (components.minute ?? 0))")
                                                                player.hoursAway = 23 - (components.hour ?? 0)
                                                                player.minutesAway = 60 - (components.minute ?? 0)
                                                                
                                                                
                                                                vm.state = .success(data: player)
                                                                
                                                                
                                                            }
                                                            else{
                                                                let stats : [String : Int] = [
                                                                    
                                                                    "todayFinalKills": player.stats.Bedwars?.final_kills_bedwars ?? 0,
                                                                    "todayFinalDeaths" : player.stats.Bedwars?.final_deaths_bedwars ?? 0,
                                                                    "todayBedwarsWins" : player.stats.Bedwars?.wins_bedwars ?? 0,
                                                                    "todayBedwarsLosses" : player.stats.Bedwars?.losses_bedwars ?? 0,
                                                                    "todayTntRunLosses" : player.stats.TNTGames?.deaths_tntrun ?? 0,
                                                                    "todayTntRunWins" : player.achievements?.tntgames_tnt_run_wins ?? 0,
                                                                    "todaySkyWarsKills" : player.stats.SkyWars?.kills ?? 0,
                                                                    "todaySkyWarsDeaths" : player.stats.SkyWars?.deaths ?? 0,
                                                                    "todaySkyWarsWins" : player.stats.SkyWars?.wins ?? 0,
                                                                    "todaySkyWarsLosses" : player.stats.SkyWars?.losses ?? 0,
                                                                    "todayDuelsWins" : player.stats.Duels?.wins ?? 0,
                                                                    "todayDuelsLosses" : player.stats.Duels?.losses ?? 0,
                                                                    "todayBridgeLosses" : player.stats.Duels?.bridgeOverallLosses ?? 0,
                                                                    "todayBridgeWins" : player.stats.Duels?.bridgeOverallWins ?? 0,
                                                                    
                                                                    
                                                                    
                                                                ]
                                                                vm.db.newPlayerDocument(data: stats, username: player.displayname, uuid: player.uuid)
                                                            }
                                                        }
                                                        
                                                        profileLoaded = true
                                                        
                                                    default:
                                                        print("default")
                                                    }
                                                    
                                                    
                                                    
                                                }
                                                
                                                
                                            } label: {
                                                ZStack(alignment: .leading){
                                                    RoundedRectangle(cornerRadius: 5)
                                                        .strokeBorder(.gray.opacity(0.5))
                                                        .padding(.horizontal, 2)
                                                    
                                                    HStack(spacing: 0){
                                                        let URL = URL(string: "https://crafatar.com/avatars/\(user.uuid)")
                                                        AsyncImage(url: URL) { image in
                                                            image
                                                                .resizable()
                                                                .scaledToFit()
                                                                .frame(maxWidth: 40)
                                                            
                                                            
                                                        } placeholder: {
                                                            ProgressView()
                                                        }
                                                        RankTextView(username: "\(user.displayName)", rankColor: "\(user.rankColor)", rank: "\(user.rank)", mvpPlusPlus: user.mvpPlusPlus)
                                                        
                                                    }
                                                    .padding(.horizontal, 20)
                                                }
                                            }
                                            .frame(maxHeight: 50)
                                            .padding(.horizontal, 15)
                                        }
                                        
                                        
                                        
                                    }
                                    .frame(maxHeight: 200)
                                    .padding(.vertical, 30)
                                }
                                
                                
                                
                                
                                
                                
                                
                                
                            }
                            
                            
                            
                            NavigationLink(isActive: $profileLoaded)
                            {
                                TabNavigationView(vm : vm)
                                
                            } label: {
                                EmptyView()
                            }
                            
                            
                            switch vm.state{
                            case .loading:
                                LoadingView()
                                    .onAppear{
                                        if settingsOn{
                                            withAnimation(.easeInOut){
                                                settingsOn.toggle()
                                            }
                                        }
                                    }
                            default:
                                EmptyView()
                            }
                        }
                        .onTapGesture{
                            if settingsOn{
                                withAnimation(.easeInOut){
                                    settingsOn.toggle()
                                }
                            }
                        }
                        
                        
                        
                        .navigationTitle("")
                        .toolbar{
                            ToolbarItem(placement: .navigationBarTrailing){
                                
                                NavigationLink{
                                    InfoView()
                                } label: {
                                    Label("Information", systemImage: "info.circle")
                                    
                                }
                                
                                
                                
                            }
                            ToolbarItem(placement: .navigationBarLeading){
                                
                                Button{
                                    withAnimation(.easeInOut){
                                        settingsOn.toggle()
                                    }
                                } label: {
                                    Image(systemName: "line.3.horizontal")
                                    
                                }
                                
                                
                                
                                
                            }
                            
                            
                        }
                        
                    }
                    .frame(width: geo.size.width)
                } else {
                    NavigationView{
                        ZStack{ //why is this a ZStack?
                            Rectangle()
                                .fill(colorScheme == .dark ? Color.black : Color.white)
                                .ignoresSafeArea()
                            VStack{
                                
                                Text("Enter Your Username:")
                                    .font(.title.bold())
                                
                                
                                TextField("Username", text: $username)
                                    .frame(width: 280)
                                    .padding(.bottom)
                                    .focused($usernameFocused)
                                
                                
                                Button{
                                    usernameFocused = false //turning keyboard off(taking the focus off of it)
                                    
                                    Task{
                                        
                                        
                                        await vm.getPlayer(username: username)
                                        switch vm.state{
                                        case .success(var player):
                                            let docRef = vm.db.collection("players").document(player.displayname)
                                            docRef.getDocument {document, error in
                                                if let document = document, document.exists {
                                                    
                                                    
                                                    print("document exists")
                                                    player.todayFinalKills = document["todayFinalKills"] as? Int
                                                    player.todayFinalDeaths = document["todayFinalDeaths"] as? Int
                                                    player.todayBedwarsWins = document["todayBedwarsWins"] as? Int
                                                    player.todayBedwarsLosses = document["todayBedwarsLosses"] as? Int
                                                    player.todayTntRunWins = document["todayTntRunWins"] as? Int
                                                    player.todayTntRunLosses = document["todayTntRunLosses"] as? Int
                                                    player.todaySkywarsKills = document["todaySkyWarsKills"] as? Int
                                                    player.todaySkywarsDeaths = document["todaySkyWarsDeaths"] as?  Int
                                                    player.todaySkyWarsWins = document["todaySkyWarsWins"] as? Int
                                                    player.todaySkyWarsLosses = document["todaySkyWarsLosses"] as? Int
                                                    player.todayDuelWins = document["todayDuelsWins"] as? Int
                                                    player.todayDuelLosses = document["todayDuelsLosses"] as? Int
                                                    player.todayBridgeWins = document["todayBridgeWins"] as? Int
                                                    player.todayBridgeLosses = document["todayBridgeLosses"] as? Int
                                                    let registerDate = (document["registerDate"] as? Timestamp)?.dateValue() ?? Date()
                                                    let components = Calendar.current.dateComponents([.minute, .hour], from: registerDate , to: Date.now)
                                                    
                                                    player.hoursAway = 23 - (components.hour ?? 0)
                                                    player.minutesAway = 60 - (components.minute ?? 0)
                                                    
                                                    
                                                    vm.state = .success(data: player)
                                                    
                                                    
                                                }
                                                else{
                                                    //its new
                                                    let stats : [String : Int] = [
                                                        
                                                        "todayFinalKills": player.stats.Bedwars?.final_kills_bedwars ?? 0,
                                                        "todayFinalDeaths" : player.stats.Bedwars?.final_deaths_bedwars ?? 0,
                                                        "todayBedwarsWins" : player.stats.Bedwars?.wins_bedwars ?? 0,
                                                        "todayBedwarsLosses" : player.stats.Bedwars?.losses_bedwars ?? 0,
                                                        "todayTntRunLosses" : player.stats.TNTGames?.deaths_tntrun ?? 0,
                                                        "todayTntRunWins" : player.achievements?.tntgames_tnt_run_wins ?? 0,
                                                        "todaySkyWarsKills" : player.stats.SkyWars?.kills ?? 0,
                                                        "todaySkyWarsDeaths" : player.stats.SkyWars?.deaths ?? 0,
                                                        "todaySkyWarsWins" : player.stats.SkyWars?.wins ?? 0,
                                                        "todaySkyWarsLosses" : player.stats.SkyWars?.losses ?? 0,
                                                        "todayDuelsWins" : player.stats.Duels?.wins ?? 0,
                                                        "todayDuelsLosses" : player.stats.Duels?.losses ?? 0,
                                                        "todayBridgeLosses" : player.stats.Duels?.bridgeOverallLosses ?? 0,
                                                        "todayBridgeWins" : player.stats.Duels?.bridgeOverallWins ?? 0,
                                                        
                                                        
                                                        
                                                        
                                                        
                                                    ]
                                                    vm.db.newPlayerDocument(data: stats, username: player.displayname, uuid: player.uuid)
                                                    let docRef = vm.db.collection("players").document(player.displayname)
                                                    docRef.getDocument {document, error in
                                                        if let document = document, document.exists {
                                                            
                                                            
                                                            print("document exists")
                                                            player.todayFinalKills = document["todayFinalKills"] as? Int
                                                            player.todayFinalDeaths = document["todayFinalDeaths"] as? Int
                                                            player.todayBedwarsWins = document["todayBedwarsWins"] as? Int
                                                            player.todayBedwarsLosses = document["todayBedwarsLosses"] as? Int
                                                            player.todayTntRunWins = document["todayTntRunWins"] as? Int
                                                            player.todayTntRunLosses = document["todayTntRunLosses"] as? Int
                                                            player.todaySkywarsKills = document["todaySkyWarsKills"] as? Int
                                                            player.todaySkywarsDeaths = document["todaySkyWarsDeaths"] as?  Int
                                                            player.todaySkyWarsWins = document["todaySkyWarsWins"] as? Int
                                                            player.todaySkyWarsLosses = document["todaySkyWarsLosses"] as? Int
                                                            player.todayDuelWins = document["todayDuelsWins"] as? Int
                                                            player.todayDuelLosses = document["todayDuelsLosses"] as? Int
                                                            player.todayBridgeWins = document["todayBridgeWins"] as? Int
                                                            player.todayBridgeLosses = document["todayBridgeLosses"] as? Int
                                                            let registerDate = (document["registerDate"] as? Timestamp)?.dateValue() ?? Date()
                                                            let components = Calendar.current.dateComponents([.minute, .hour], from: registerDate , to: Date.now)
                                                            
                                                            player.hoursAway = 23 - (components.hour ?? 0)
                                                            player.minutesAway = 60 - (components.minute ?? 0)
                                                            
                                                            
                                                            vm.state = .success(data: player)
                                                            
                                                            
                                                        }
                                                    }
                                                }
                                            }
                                            let newUser = SavedPlayer(displayName: player.displayname, uuid: player.uuid, rankColor: player.rankPlusColor ?? "BLACK", rank: player.newPackageRank ?? "", mvpPlusPlus: player.monthlyPackageRank == "SUPERSTAR" ? true : false)
                                            var duplicate = false
                                            for user in users{
                                                if user.uuid == newUser.uuid{
                                                    duplicate = true
                                                }
                                            }
                                            
                                            if(!duplicate && users.count == 3){
                                                let tempUser = users[0]
                                                users[0] = newUser
                                                let tempUserTwo = users[1]
                                                users[1] = tempUser
                                                users[2] = tempUserTwo
                                                
                                            }
                                            else if(!duplicate){
                                                users.append(SavedPlayer(displayName: player.displayname, uuid: player.uuid, rankColor: player.rankPlusColor ?? "BLACK", rank: player.newPackageRank ?? "", mvpPlusPlus: player.monthlyPackageRank == "SUPERSTAR" ? true : false))
                                            }
                                            
                                            let encoder = JSONEncoder()
                                            if let data = try? encoder.encode(users){
                                                UserDefaults.standard.set(data, forKey: "users")
                                            }
                                            profileLoaded = true
                                        default:
                                            print("default")
                                        }
                                        
                                        
                                        
                                    }
                                } label:
                                {
                                    
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 5)
                                            .fill(isDarkMode  ? Color(red: 214/255, green: 15/255, blue: 81/255) : .gray)
                                            .frame(width: 200, height: 50)
                                        
                                        Text("Search")
                                            .foregroundColor(.white)
                                        
                                        
                                        
                                    }
                                }
                                
                                
                                //we need to check if the vm.state enum is in the .failed type
                                
                                //very very replacable
                                switch vm.state{
                                case .failed(let error):
                                    if(error.localizedDescription=="The Internet connection appears to be offline."){
                                        Text("Your internet appears to be offline.")
                                            .foregroundColor(.red)
                                    }
                                    else{
                                        Text("Something went wrong, please try again.")
                                            .foregroundColor(.red)
                                    }
                                    
                                default:
                                    EmptyView()
                                }
                                //super replaceable
                                
                                //list of recent players
                                
                                
                                // VSTACK GOES HERE.
                                if recentPlayersOn{
                                    VStack(alignment: .leading){
                                        Text("Recent Users:")
                                            .font(.body.bold())
                                            .padding(.horizontal, 15)
                                        ForEach(users, id: \.uuid) { user in
                                            Button{
                                                Task{
                                                    await vm.getPlayer(username: "\(user.displayName)")
                                                    switch vm.state{
                                                    case .success(var player):
                                                        let docRef = vm.db.collection("players").document(player.displayname)
                                                        docRef.getDocument {document, error in
                                                            if let document = document, document.exists {
                                                                
                                                                
                                                                print("document exists")
                                                                player.todayFinalKills = document["todayFinalKills"] as? Int
                                                                player.todayFinalDeaths = document["todayFinalDeaths"] as? Int
                                                                player.todayBedwarsWins = document["todayBedwarsWins"] as? Int
                                                                player.todayBedwarsLosses = document["todayBedwarsLosses"] as? Int
                                                                player.todayTntRunWins = document["todayTntRunWins"] as? Int
                                                                player.todayTntRunLosses = document["todayTntRunLosses"] as? Int
                                                                player.todaySkywarsKills = document["todaySkyWarsKills"] as? Int
                                                                player.todaySkywarsDeaths = document["todaySkyWarsDeaths"] as?  Int
                                                                player.todaySkyWarsWins = document["todaySkyWarsWins"] as? Int
                                                                player.todaySkyWarsLosses = document["todaySkyWarsLosses"] as? Int
                                                                player.todayDuelWins = document["todayDuelsWins"] as? Int
                                                                player.todayDuelLosses = document["todayDuelsLosses"] as? Int
                                                                player.todayBridgeWins = document["todayBridgeWins"] as? Int
                                                                player.todayBridgeLosses = document["todayBridgeLosses"] as? Int
                                                                let registerDate = (document["registerDate"] as? Timestamp)?.dateValue() ?? Date()
                                                                let components = Calendar.current.dateComponents([.minute, .hour], from: registerDate , to: Date.now)
                                                                print("difference is \(components.hour ?? 0) hours and \(components.minute ?? 0) minutes.")
                                                                print("resets in \(23 - (components.hour ?? 0))hours and \(60 - (components.minute ?? 0))")
                                                                player.hoursAway = 23 - (components.hour ?? 0)
                                                                player.minutesAway = 60 - (components.minute ?? 0)
                                                                
                                                                
                                                                vm.state = .success(data: player)
                                                                
                                                                
                                                            }
                                                            else{
                                                                let stats : [String : Int] = [
                                                                    
                                                                    "todayFinalKills": player.stats.Bedwars?.final_kills_bedwars ?? 0,
                                                                    "todayFinalDeaths" : player.stats.Bedwars?.final_deaths_bedwars ?? 0,
                                                                    "todayBedwarsWins" : player.stats.Bedwars?.wins_bedwars ?? 0,
                                                                    "todayBedwarsLosses" : player.stats.Bedwars?.losses_bedwars ?? 0,
                                                                    "todayTntRunLosses" : player.stats.TNTGames?.deaths_tntrun ?? 0,
                                                                    "todayTntRunWins" : player.achievements?.tntgames_tnt_run_wins ?? 0,
                                                                    "todaySkyWarsKills" : player.stats.SkyWars?.kills ?? 0,
                                                                    "todaySkyWarsDeaths" : player.stats.SkyWars?.deaths ?? 0,
                                                                    "todaySkyWarsWins" : player.stats.SkyWars?.wins ?? 0,
                                                                    "todaySkyWarsLosses" : player.stats.SkyWars?.losses ?? 0,
                                                                    "todayDuelsWins" : player.stats.Duels?.wins ?? 0,
                                                                    "todayDuelsLosses" : player.stats.Duels?.losses ?? 0,
                                                                    "todayBridgeLosses" : player.stats.Duels?.bridgeOverallLosses ?? 0,
                                                                    "todayBridgeWins" : player.stats.Duels?.bridgeOverallWins ?? 0,
                                                                    
                                                                    
                                                                    
                                                                ]
                                                                vm.db.newPlayerDocument(data: stats, username: player.displayname, uuid: player.uuid)
                                                            }
                                                        }
                                                        
                                                        profileLoaded = true
                                                        
                                                    default:
                                                        print("default")
                                                    }
                                                    
                                                    
                                                    
                                                }
                                                
                                                
                                            } label: {
                                                ZStack(alignment: .leading){
                                                    RoundedRectangle(cornerRadius: 5)
                                                        .strokeBorder(.gray.opacity(0.5))
                                                        .padding(.horizontal, 2)
                                                    
                                                    HStack(spacing: 0){
                                                        let URL = URL(string: "https://crafatar.com/avatars/\(user.uuid)")
                                                        AsyncImage(url: URL) { image in
                                                            image
                                                                .resizable()
                                                                .scaledToFit()
                                                                .frame(maxWidth: 40)
                                                            
                                                            
                                                        } placeholder: {
                                                            ProgressView()
                                                        }
                                                        RankTextView(username: "\(user.displayName)", rankColor: "\(user.rankColor)", rank: "\(user.rank)", mvpPlusPlus: user.mvpPlusPlus)
                                                        
                                                    }
                                                    .padding(.horizontal, 20)
                                                }
                                            }
                                            .frame(maxHeight: 50)
                                            .padding(.horizontal, 15)
                                        }
                                        
                                        
                                        
                                    }
                                    .frame(maxHeight: 200)
                                    .padding(.vertical, 30)
                                }
                                
                                
                                
                                
                                
                                
                                
                                
                            }
                            
                            
                            
                            NavigationLink(isActive: $profileLoaded)
                            {
                                TabNavigationView(vm : vm)
                                
                            } label: {
                                EmptyView()
                            }
                            
                            
                            switch vm.state{
                            case .loading:
                                LoadingView()
                                    .onAppear{
                                        if settingsOn{
                                            withAnimation(.easeInOut){
                                                settingsOn.toggle()
                                            }
                                        }
                                    }
                            default:
                                EmptyView()
                            }
                        }
                        .onTapGesture{
                            if settingsOn{
                                withAnimation(.easeInOut){
                                    settingsOn.toggle()
                                }
                            }
                        }
                        
                        
                        
                        .navigationTitle("")
                        .toolbar{
                            ToolbarItem(placement: .navigationBarTrailing){
                                
                                NavigationLink{
                                    InfoView()
                                } label: {
                                    Label("Information", systemImage: "info.circle")
                                    
                                }
                                
                                
                                
                            }
                            ToolbarItem(placement: .navigationBarLeading){
                                
                                Button{
                                    withAnimation(.easeInOut){
                                        settingsOn.toggle()
                                    }
                                } label: {
                                    Image(systemName: "line.3.horizontal")
                                    
                                }
                                
                                
                                
                                
                            }
                            
                            
                        }
                        
                    }
                    .frame(width: geo.size.width)
                }
                
                
                
               
                
               
                
            }
            
            }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        }
        
        
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(vm: PlayerViewModel(service: PlayerService()))
    }
}
