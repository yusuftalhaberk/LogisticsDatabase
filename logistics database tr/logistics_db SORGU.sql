-- ÖRNEK SORGULAR
SELECT * FROM soforler;

SELECT * FROM soforler order by KatedilenMesafeKM desc;

-- şoförlerin tır ve görev bilgileri
SELECT 
    S.SoforIsmi,
    T.MarkaModel,
    Gv.Yuk,
    Gv.KutleTon,
    Gv.Sirket
FROM SOFORLER S
JOIN TIRLAR T ON S.TirID = T.TirID
JOIN Gorevler Gv ON S.GorevID = Gv.GorevID;

-- Görevlerin Şirket Bazlı Toplam Tonajları (Çoktan->Aza)
SELECT 
    Sirket,
    SUM(KutleTon) AS ToplamTonaj
FROM Gorevler
GROUP BY Sirket
order by ToplamTonaj desc;