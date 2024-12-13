import Debug "mo:base/Debug";
import Time "mo:base/Time";

actor YilanOyunu {
    type Direction = { #Up; #Down; #Left; #Right };
    type Position = { x: Int; y: Int };

    var yilan: [Position] = [{ x = 5; y = 5 }];
    var yem: Position = { x = 10; y = 10 };
    var yon: Direction = #Right;

    public func baslat() : async Text {
        return "Yilan Oyunu Başlatildi!";
    };

    public func hareketEt() : async Text {
        let baslangic = yilan[0];
        let yeniBaslangic = switch (yon) {
            case (#Up)    { x = baslangic.x; y = baslangic.y + 1 };
            case (#Down)  { x = baslangic.x; y = baslangic.y - 1 };
            case (#Left)  { x = baslangic.x - 1; y = baslangic.y };
            case (#Right) { x = baslangic.x + 1; y = baslangic.y };
        };

        // Yemi yedi mi kontrol et
        if (yeniBaslangic.x == yem.x && yeniBaslangic.y == yem.y) {
            yilan := [yeniBaslangic] # yilan; // Yılanın başını ekle
            yem := { x = Int.random(0, 20); y = Int.random(0, 20) }; // Yeni yem konumu
        } else {
            yilan := [yeniBaslangic] # yilan[0..(Array.size(yilan) - 2)]; // Yılanın başını ekle ve kuyruğu çıkar
        };

        return "Yilan hareket etti!";
    };

    public func yonuDegistir(yeniYon: Direction) : async Text {
        yon := yeniYon;
        return "Yön değiştirildi!";
    };

    public func durumGoster() : async Text {
        return "Yilan: " # Debug.show(yilan) # ", Yem: " # Debug.show(yem);
    };
};
