---


---

<h1 id="soalshiftsisop20_modul1_t12">SoalShiftSISOP20_modul1_T12</h1>
<p><code>"Repository dibuat untuk memenuhi tugas praktikum mata kuliah sistem operasi tahun 2020."</code></p>
<p>Anggota :<br>
<strong>Muhammad Ilya Asha Soegondo</strong> <code>[05311840000010]</code><br>
<strong>Mohammad Ifaizul Hasan</strong> <code>[05311840000029]</code></p>
<p>Asisten :<br>
<strong>Nandha Himawan</strong> <code>[05111740000180]</code></p>
<h2 id="pendahuluan">Pendahuluan</h2>
<h3 id="prasyarat">Prasyarat</h3>
<ul>
<li>Sebuah distribusi Linux (misal: Ubuntu, Linux Mint)</li>
<li><strong>gawk</strong> (GNU awk)<br>
<code>sudo apt-get install gawk</code></li>
</ul>
<h2 id="modul-1">Modul 1</h2>
<h3 id="soal-1">Soal 1</h3>
<p>Whits adalah seorang mahasiswa teknik informatika. Dia mendapatkan tugas praktikum untuk membuat laporan berdasarkan data yang ada pada file “<mark>Sample-Superstore.csv</mark>”. Namun dia tidak dapat menyelesaikan tugas tersebut. Laporan yang diminta berupa :<br>
<strong>a. Tentukan wilayah bagian (region) mana yang memiliki keuntungan (profit) paling sedikit<br>
b. Tampilkan 2 negara bagian (state) yang memiliki keuntungan (profit) paling<br>
sedikit berdasarkan hasil poin a<br>
c. Tampilkan 10 produk (product name) yang memiliki keuntungan (profit) paling sedikit berdasarkan 2 negara bagian (state) hasil poin b</strong><br>
Whits memohon kepada kalian yang sudah jago mengolah data untuk mengerjakan<br>
laporan tersebut.<br>
<em>Gunakan Awk dan Command pendukung</em></p>
<h4 id="penyelesaian">Penyelesaian</h4>
<p><em><strong>a.</strong></em> Wilayah bagian dengan keuntungan paling sedikit</p>
<p><code>region=($(awk -F "\"*,\"*" 'FNR&gt;1{u[$13]+=$21}END{for(i in u)printf "%6.4f %s \n", u[i], i}' Sample-Superstore.csv | sort -g | head -n1))</code></p>
<ol>
<li>Mengolah <mark>Sample-Superstore.csv</mark> menggunakan <code>awk</code> dengan cara menentukan <em>field separator</em> <code>","</code> <code>-F "\"*,\"*"</code>, melewati kolom header <code>FNR&gt;1</code>, menggunakan <em>array</em> untuk mengelompokkan keuntungan berdasarkan wilayah bagian <code>u[$13]+=$21</code>, dan menampilkan setiap elemen dari <em>array</em> tersebut beserta <em>value</em>-nya <code>for(i in u)printf "%6.4f %s \n", u[i], i</code>,</li>
<li>Mengurutkan keuntungan dari kecil ke besar menggunakan <code>sort</code> dan <code>-g</code> untuk mengurutkan secara <em>general numerik</em></li>
<li>Menampilkan baris pertama menggunakan <code>head -n1</code></li>
<li>Hasil yang berupa wilayah bagian dengan keuntungan terkecil beserta keuntungannya disimpan pada variabel <code>region</code></li>
</ol>
<p><em><strong>b.</strong></em> 2 negara bagian dengan keuntungan paling sedikit pada wilayah bagian dari poin a</p>
<p><code>state=($(awk -F "\"*,\"*" -v a=${region[1]} 'FNR&gt;1{if($13~a)u[$11]+=$21}END{for(i in u)printf "%6.4f %s \n", u[i], i}' Sample-Superstore.csv | sort -g | head -n2))</code></p>
<ol>
<li>Mengolah <mark>Sample-Superstore.csv</mark> menggunakan <code>awk</code> dengan cara menentukan <em>field separator</em> <code>","</code> <code>-F "\"*,\"*"</code>,  menggunakan hasil dari poin a dengan mengoper variabel <code>region</code> ke dalam <code>awk</code> <code>-v a=${region[1]}</code>, melewati kolom header <code>FNR&gt;1</code>, jika wilayah bagian adalah wilayah bagian dari poin a <code>if($13~a)</code> maka digunakan <em>array</em> untuk mengelompokkan keuntungan berdasarkan negara bagian <code>u[$11]+=$21</code>, dan menampilkan setiap elemen dari <em>array</em> tersebut beserta <em>value</em>-nya <code>for(i in u)printf "%6.4f %s \n", u[i], i</code>,</li>
<li>Mengurutkan keuntungan dari kecil ke besar menggunakan <code>sort</code> dan <code>-g</code> untuk mengurutkan secara <em>general numerik</em></li>
<li>Menampilkan dua baris pertama menggunakan <code>head -n2</code></li>
<li>Hasil yang berupa 2 negara bagian dengan keuntungan terkecil beserta keuntungannya disimpan pada variabel <code>state</code></li>
</ol>
<p><em><strong>c.</strong></em> 10 produk dengan keuntungan paling sedikit pada 2 negara bagian dari poin b<br>
<code>prod12=($(awk -F "\"*,\"*" -v a=${state[1]} -v b=${state[3]} 'FNR&gt;1{if($11~a||$11~b)u[$17]+=$21}END{for(i in u)printf "%5.4f in %s\\n\n",u[i],i}' Sample-Superstore.csv | sort -g | head -n10 | nl -s"."))</code></p>
<ol>
<li>Mengolah <mark>Sample-Superstore.csv</mark> menggunakan <code>awk</code> dengan cara menentukan <em>field separator</em> <code>","</code> <code>-F "\"*,\"*"</code>,  menggunakan hasil dari poin b dengan mengoper variabel <code>state</code> ke dalam <code>awk</code> <code>-v a=${state[1]} -v b=${state[3]}</code>, melewati kolom header <code>FNR&gt;1</code>, jika negara bagian adalah negara bagian dari poin b <code>if($11~a||$11~b)</code> maka digunakan <em>array</em> untuk mengelompokkan keuntungan berdasarkan produk <code>u[$17]+=$21</code>, dan menampilkan setiap elemen dari <em>array</em> tersebut beserta <em>value</em>-nya <code>for(i in u)printf "%5.4f in %s\\n\n",u[i],i</code>,</li>
<li>Mengurutkan keuntungan dari kecil ke besar menggunakan <code>sort</code> dan <code>-g</code> untuk mengurutkan secara <em>general numerik</em></li>
<li>Menampilkan sepuluh baris pertama menggunakan <code>head -n10</code></li>
<li>Hasil yang berupa 10 produk dengan keuntungan terkecil beserta keuntungannya disimpan pada variabel <code>prod12</code></li>
</ol>
<h4 id="hasil">Hasil</h4>
<pre><code>Central Region has the lowest profit at 41340.4137

2 States with lowest profit in Central region :
 1.Texas at -20198.3212
 2.Illinois at -9246.8718

10 Products with lowest profit in both states :
 1.-5552.8392 in GBC DocuBind P400 Electric Binding System
 2.-3431.6730 in Fellowes PB500 Electric Punch Plastic Comb Binding Machine with Manual Bind
 3.-2929.4845 in Ibico EPK-21 Electric Binding System
 4.-1869.9890 in Lexmark MX611dhe Monochrome Laser Printer
 5.-1601.1975 in Ibico Hi-Tech Manual Binding System
 6.-1480.0335 in GBC DocuBind TL300 Electric Binding System
 7.-1378.8216 in 3.6 Cubic Foot Counter Height Office Refrigerator
 8.-1181.2824 in Hoover Upright Vacuum With Dirt Cup
 9.-1147.0074 in GBC ProClick 150 Presentation Binding System
 10.-1141.4700 in GBC Ibimaster 500 Manual ProClick Binding System
</code></pre>
<h3 id="soal-2">Soal 2</h3>
<p>Pada suatu siang, laptop Randolf dan Afairuzr dibajak oleh seseorang dan kehilangan data-data penting. Untuk mencegah kejadian yang sama terulang kembali mereka meminta bantuan kepada Whits karena dia adalah seorang yang punya banyak ide. Whits memikirkan sebuah ide namun dia meminta bantuan kalian kembali agar ide tersebut cepat diselesaikan. Idenya adalah kalian<br>
<strong>a. membuat sebuah script bash yang dapat menghasilkan password secara acak sebanyak 28 karakter yang terdapat huruf besar, huruf kecil, dan angka.<br>
b. Password acak tersebut disimpan pada file berekstensi .txt dengan nama berdasarkan argumen yang diinputkan dan HANYA berupa alphabet.<br>
c. Kemudian supaya file .txt tersebut tidak mudah diketahui maka nama filenya akan di enkripsi dengan menggunakan konversi huruf (string manipulation) yang disesuaikan dengan jam(0-23) dibuatnya file tersebut dengan program terpisah dengan</strong> (misal: password.txt dibuat pada jam 01.28 maka namanya berubah menjadi qbttxpse.txt dengan perintah ‘bash soal2_enkripsi.sh password.txt’. Karena p adalah huruf ke 16 dan file dibuat pada jam 1 maka 16+1=17 dan huruf ke 17 adalah q dan begitu pula seterusnya. Apabila melebihi z, akan kembali ke a, contoh: huruf w dengan jam 5.28, maka akan menjadi huruf b.) dan<br>
<strong>d. jangan lupa untuk membuat dekripsinya supaya nama file bisa kembali.</strong><br>
<em>HINT: enkripsi yang digunakan adalah caesar cipher.</em><br>
<em>Gunakan Bash Script</em></p>
<h4 id="penjelasan">Penjelasan</h4>
<h4 id="penyelesaian-1">Penyelesaian</h4>
<h3 id="soal-3">Soal 3</h3>
<p>1 tahun telah berlalu sejak pencampakan hati Kusuma. Akankah sang pujaan hati kembali ke naungan Kusuma? Memang tiada maaf bagi Elen. Tapi apa daya hati yang sudah hancur, Kusuma masih terguncang akan sikap Elen. Melihat kesedihan Kusuma, kalian mencoba menghibur Kusuma dengan mengirimkan gambar kucing. [a] <mark>Maka dari itu, kalian mencoba membuat script untuk mendownload 28 gambar dari <a href="https://loremflickr.com/320/240/cat">https://loremflickr.com/320/240/cat</a>" menggunakan command wget dan menyimpan file dengan nama “pdkt_kusuma_NO” (contoh: pdkt_kusuma_1, pdkt_kusuma_2, pdkt_kusuma_3) serta jangan lupa untuk menyimpan log messages wget kedalam sebuah file “wget.log”.</mark> Karena kalian gak suka ribet, kalian membuat penjadwalan untuk menjalankan script download gambar tersebut. Namun, script download tersebut hanya berjalan[b] <mark>setiap 8 jam dimulai dari jam 6.05 setiap hari kecuali hari Sabtu</mark> Karena gambar yang didownload dari link tersebut bersifat random, maka ada kemungkinan gambar yang terdownload itu identik. Supaya gambar yang identik tidak dikira Kusuma sebagai spam, maka diperlukan sebuah script untuk memindahkan salah satu gambar identik. Setelah memilah gambar yang identik, maka dihasilkan gambar yang berbeda antara satu dengan yang lain. Gambar yang berbeda tersebut, akan kalian kirim ke Kusuma supaya hatinya kembali ceria. Setelah semua gambar telah dikirim, kalian akan<br>
selalu menghibur Kusuma, jadi gambar yang telah terkirim tadi akan kalian simpan kedalam folder /kenangan dan kalian bisa mendownload gambar baru lagi. [c] <mark>Maka dari itu buatlah sebuah script untuk mengidentifikasi gambar yang identik dari keseluruhan gambar yang terdownload tadi. Bila terindikasi sebagai gambar yang identik, maka sisakan 1 gambar dan pindahkan sisa file identik tersebut ke dalam folder ./duplicate<br>
dengan format filename “duplicate_nomor” (contoh : duplicate_200, duplicate_201). Setelah itu lakukan pemindahan semua gambar yang tersisa kedalam folder ./kenangan<br>
dengan format filename “kenangan_nomor” (contoh: kenangan_252, kenangan_253). Setelah tidak ada gambar di current directory, maka lakukan backup seluruh log menjadi<br>
ekstensi “.log.bak”.</mark><br>
<em>Hint : Gunakan wget.log untuk membuat location.log yang isinya<br>
merupakan hasil dari grep “Location”. Gunakan Bash, Awk dan Crontab</em></p>
<h4 id="penjelasan-1">Penjelasan</h4>
<h4 id="penyelesaian-2">Penyelesaian</h4>

