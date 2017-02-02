//
//  AudioAnalysisLite.swift
//  Fou.run()
//
//  Copyright © 2016 Shock&Awe. All rights reserved.
//
import Foundation
import AudioKit


func fftAnalysis() {
    // Quante classi di frequenze vogliamo considerare nel nostro calcolo e su quanti istanti precedenti al corrente vogliamo mediare per ottenere una soglia
    let totalFrequencies = 20
    let numerosita = 400
    
    
    //Da qui, tutto codice per istanziare e far partire il player
    var file: AKAudioFile
    var player1: AKAudioPlayer?
    
    do {
        file = try AKAudioFile.init(readFileName: "daft.mp3")
        do{
            player1 = try AKAudioPlayer(file: file)
        }catch{}
    } catch {}
    
    if let player = player1 {
        let variatore = AKVariSpeed(player)
        
        player.looping = false
        variatore.rate = 1.0
        
        AudioKit.output = variatore
        AudioKit.start()
        player.play()
        print(player.duration)
        
        print("musica!")
        let fft = AKFFTTap(player)
        
        // medie ha la stessa dimensione di "totalfrequencies". I suoi valori, ad ogni istante, corrisponderanno alla media di un numero di campionamenti precedenti pari a "numerosita"
        var medie = [Double]()
        // un contatore solo per vedere quante volte viene ripetuto il loop
        var counter: Int = 0
        // in questo vettore, ad ogni istante, vengono registrati i valori delle singole frequenze, ai fini di calcolare le medie. Ad ogni loop viene poi scritto in "tabellaMedie" e ripulito non appena ne inizia un altro.
        var colonnaIstante = [Double]()
        // come il precedente, ma finalizzato a registrare tutti i dati del pezzo. Il primo elemento sarà il tempo in secondi all'interno della canzone
        var colonnaIstanteConIndice = [Double]()
        // in tabellaMedie, il primo indice corrisponde al numero del campionamento (quindi al tempo nella canzone), e ad ogni indice corrisponde un vettore colonnaIstante. A differenza di tabellaValori, il numero di istanti considerati è fissato a "numerosita", e ad ogni loop viene eliminato il più vecchio ed introdotto il più recente.
        var tabellaMedie = [[Double]]()
         //questo è il modello della struttura dati definitiva. Ad ogni indice corrisponde un dictionary dove gli elementi sono  time, low, mid e high. Alla classe di frequenza corrisponde un intero arbitrario vagamente proporzionale all'intensità.
        var tabellaDictionary = [NSMutableDictionary]()
        // In queste tabelle i valori sono direttamente i tempi in cui nella canzone si verificano gli eventi.
        var tabellaLow = [Double]()
        var tabellaMid = [Double]()
        var tabellaHigh = [Double]()
        
        
        for _ in 0..<totalFrequencies {
            medie.append(0)
            colonnaIstante.append(0)
        }
        
        for _ in 0...numerosita {
            tabellaMedie.append(colonnaIstante)
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (timer) in
            counter += 1
            
            //Svuotiamo l'array con le informazioni sull'istante corrente
            colonnaIstanteConIndice.removeAll()
            //Per prima cosa, gli aggiungiamo il currentTime nella canzone
            colonnaIstanteConIndice.append(player.currentTime)
            
            //Aggiorniamo la tabella per calcolare le medie, togliendo la più vecchia ed aggiungendo la più nuova
            tabellaMedie.remove(at: numerosita)
            tabellaMedie.insert(colonnaIstante, at: 0)
            
            //    Qui stiamo ciclando tra tutte le frequenze. Cancelliamo il precedente valore della media e lo ricalcoliamo, andando nella tabellaMedie, fissando il secondo indice che corrisponde alla frequenza e variando il primo, che invece corrisponde al tempo. Ricordiamoci che la tabellaMedie ha grandezza fissata e che i suoi vettori vengono continuamente aggiornati, quindi quando si parla di tempo si fa riferimento sempre agli ultimi "numerosita" campionamenti.
            
            for index in 0..<totalFrequencies {
                medie[index] = 0
                colonnaIstante[index] = fft.fftData[index]
                // la riga seguente è commentata perchè, ovviamente, alternativa ad append[1]
                // colonnaIstanteConIndice.append(fft.fftData[index])
                
            for k in 0...numerosita {
                    medie[index] += tabellaMedie[k][index]/numerosita
                }
                
                //Dunque, se il valore corrente per la determinata frequenza è maggiore della media degli ultimi "numerosita" valori, allore registriamo l'evento. Come sempre, ignoriamo le immagini.
                
            if fft.fftData[index] > medie[index]{
                    colonnaIstanteConIndice.append(1)
                } else { colonnaIstanteConIndice.append(0) }
            }
            
//            La nostra colonnaIstanteConIndice ora è completa (primo elemento tempo + tanti elementi quanto totalFrequencies) e la possiamo aggiungere alla tabellaDictionary. 
//                Nelle tabelle Low, Mid e High, se le funzioni di verifica restituiscono true, aggiungiamo il tempo.
//            Tutto questo, se la canzone non è finita; altrimenti, se la canzone è finita, vediamo un attimo al terminale cosa ne è uscito.
            
            if player.endTime - player.currentTime > 0.3 {
                tabellaDictionary.append(fillDictionary(items: colonnaIstanteConIndice))
//                print(player.endTime - player.currentTime)
                if fillLows(items: colonnaIstanteConIndice) {
                    tabellaLow.append(player.currentTime)
                }
                if fillMids(items: colonnaIstanteConIndice) {
                    tabellaMid.append(player.currentTime)
                }
                if fillHighs(items: colonnaIstanteConIndice){
                    tabellaHigh.append(player.currentTime)
                }
            
            } else {
                minchia(tab: tabellaDictionary)
                print(tabellaDictionary.count)
                print(tabellaLow.count)
                print(tabellaMid.count)
                print(tabellaHigh.count)
                timer.invalidate()
                player.stop()
            }

        })
        
    } else { print("somehow player not init")}
}

func fillDictionary(items: [Double], elements: Int) -> NSMutableDictionary {
    
    let dict = NSMutableDictionary()
    
    for i in 0..<elements {
        if i == 0 {
            dict.setObject(items[i], forKey: "time" as NSCopying)
        }
        else {
            dict.setObject(items[i], forKey: "f\(i)" as NSCopying)
        }
    }
    
    return dict
    
}

func fillDictionaryNoTime(items:[Double]) -> NSMutableDictionary {
    
    let dict = NSMutableDictionary()
    var bassi: Double = 0
    var medi: Double = 0
    var alti: Double = 0
    
    for i in 1...3 {
        bassi += items[i]
    }
    
    for i in 4...10 {
        medi += items[i]
    }
    
    for i in 11...20 {
        alti += items[i]
    }
    
    dict.setObject(bassi, forKey: "low" as NSCopying)
    dict.setObject(medi, forKey: "mid" as NSCopying)
    dict.setObject(alti, forKey: "high" as NSCopying)
    
    return dict

}


func fillDictionary(items: [Double]) -> NSMutableDictionary {
    let dict = NSMutableDictionary()
    var bassi: Double = 0
    var medi: Double = 0
    var alti: Double = 0
    
    for i in 1...3 {
        bassi += items[i]
    }
    
    for i in 4...10 {
        medi += items[i]
    }
    
    for i in 11...20 {
        alti += items[i]
    }
    
    dict.setObject(items[0], forKey: "time" as NSCopying)
    dict.setObject(bassi, forKey: "low" as NSCopying)
    dict.setObject(medi, forKey: "mid" as NSCopying)
    dict.setObject(alti, forKey: "high" as NSCopying)
    
    return dict
}


func fillLows(items: [Double]) -> Bool {
    var bassi: Double = 0

    for i in 1...3 {
        bassi += items[i]
    }
    
    if bassi > 2 {
        return true
    } else { return false}
}


func fillMids(items: [Double]) -> Bool {
    var medi: Double = 0
    
    for i in 4...10 {
        medi += items[i]
    }
    
    if medi > 5 {
        return true
    } else { return false}
}



func fillHighs(items: [Double]) -> Bool {
    var alti: Double = 0

    for i in 11...20 {
        alti += items[i]}
    if alti > 7 {
        return true
    } else { return false}
}

func minchia(tab: [NSMutableDictionary]) {
    
    do {
    
        let minchia = FileManager()
        
        let documentUrl = try minchia.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        
        let jsonPath = documentUrl.appendingPathComponent("json.json")
        let jsonHandle = documentUrl.appendingPathComponent("jsonHandle.json")
        
        minchia.createFile(atPath: jsonPath.relativePath, contents: nil, attributes: nil)
        minchia.createFile(atPath: jsonHandle.relativePath, contents: nil, attributes: nil)
        print(jsonPath.relativePath)
        print(jsonHandle.relativePath)
        
        let file = FileHandle(forWritingAtPath: jsonHandle.relativePath)
        let parsed = try JSONSerialization.data(withJSONObject: tab, options: .prettyPrinted)
        file?.write(parsed)
        
        let stream = OutputStream(toFileAtPath: jsonPath.relativePath, append: true)
        stream?.open()
        JSONSerialization.writeJSONObject(tab, to: stream!, options: .prettyPrinted, error: nil)
        stream?.close()
    } catch { print("errore") }
}

func minchia(tab: NSMutableDictionary) {
    
    do {
        
        let minchia = FileManager()
        
        let documentUrl = try minchia.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        
        let jsonPath = documentUrl.appendingPathComponent("json.json")
        let jsonHandle = documentUrl.appendingPathComponent("jsonHandle.json")
        
        minchia.createFile(atPath: jsonPath.relativePath, contents: nil, attributes: nil)
        minchia.createFile(atPath: jsonHandle.relativePath, contents: nil, attributes: nil)
        print(jsonPath.relativePath)
        print(jsonHandle.relativePath)
        
        let file = FileHandle(forWritingAtPath: jsonHandle.relativePath)
        let parsed = try JSONSerialization.data(withJSONObject: tab, options: .prettyPrinted)
        file?.write(parsed)
        
        let stream = OutputStream(toFileAtPath: jsonPath.relativePath, append: true)
        stream?.open()
        JSONSerialization.writeJSONObject(tab, to: stream!, options: .prettyPrinted, error: nil)
        stream?.close()
    } catch { print("errore") }
}
