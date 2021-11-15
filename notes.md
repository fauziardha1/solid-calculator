## Solid Calculator Notes and Questions

###### Question
1. Pada halaman 37, step 2 dan substep terakhir tertulis : 
    ```maka ulangi perhitungan langkah 2 ini ke children-children dari subclass tersebut.``` Namun pada awal step 2 dikatakan bahwa langkan ini dilakukan untuk setiap pasangan baseclass-subclass. 
    Kemudian baseclass didefinisikan sebagai class dengan Dept of Inheritanace(DIT) =0,
    Apakah subclass yang dijadikan parent oleh class lain dibawahnya juga termasuk baseclass?
    Jika iya, maka terjadi kesalahan definisi baseclass dan akan menyebabkan terjadinya perhitungan yang redundan dan recursive.
    Jika tidak, maka substep terakhir pada step 2 ini tidak diperlukan.

2. Pada langkah ke4 pada halaman 38, tertulis bahwa jika subclass adalah abstract maka lakukan perhitungan langkah ke-2 untuk children nya. disini apakah subclass yang abstract ini terhitung sebagai baseclass? 
Jika iya maka perhitungan NOH seharusnya juga bertambah, dan perhitungan NOH diawal jadi redundan dan tidak relevan dilakukan.
Jika tidak maka langkah ke-4 ini tidak perlu dilakukan.

3. Kapan(case seperti apa) kasus terjadinya NME > NMIa?
4. Apakah interface termasuk baseclass?
5. Bagaimana jika baseclass tidak memiliki child? apakah terhitung sebagai CLSP?
6. 