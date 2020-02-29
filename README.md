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
<li>Sebuah distribusi Linux (misal: Ubuntu, Linux Mint).</li>
<li><strong>gawk</strong> (GNU awk).<br>
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
<em>Gunakan Awk dan Command pendukung</em>.</p>
<h4 id="penyelesaian">Penyelesaian</h4>
<p><em><strong>a.</strong></em> Wilayah bagian dengan keuntungan paling sedikit</p>
<p><code>region=($(awk -F "\"*,\"*" 'FNR&gt;1{u[$13]+=$NF}END{for(i in u)printf "%6.4f %s \n", u[i], i}' Sample-Superstore.csv | sort -g | head -n1))</code></p>
<ol>
<li>Mengolah <mark>Sample-Superstore.csv</mark> menggunakan <code>awk</code> dengan cara menentukan <em>field separator</em> <code>","</code> <code>-F "\"*,\"*"</code>, melewati kolom header <code>FNR&gt;1</code>, menggunakan <em>array</em> untuk mengelompokkan keuntungan berdasarkan wilayah bagian <code>u[$13]+=$NF</code>, dan menampilkan setiap elemen dari <em>array</em> tersebut beserta <em>value</em>-nya <code>for(i in u)printf "%6.4f %s \n", u[i], i</code>.</li>
<li>Mengurutkan keuntungan dari kecil ke besar menggunakan <code>sort</code> dan <code>-g</code> untuk mengurutkan secara <em>general numerik</em>.</li>
<li>Menampilkan baris pertama menggunakan <code>head -n1</code>.</li>
<li>Hasil yang berupa wilayah bagian dengan keuntungan terkecil beserta keuntungannya disimpan pada variabel <code>region</code>.</li>
</ol>
<p><em><strong>b.</strong></em> 2 negara bagian dengan keuntungan paling sedikit pada wilayah bagian dari poin a</p>
<p><code>state=($(awk -F "\"*,\"*" -v a=${region[1]} 'FNR&gt;1{if($13~a)u[$11]+=$NF}END{for(i in u)printf "%6.4f %s \n", u[i], i}' Sample-Superstore.csv | sort -g | head -n2))</code></p>
<ol>
<li>Mengolah <mark>Sample-Superstore.csv</mark> menggunakan <code>awk</code> dengan cara menentukan <em>field separator</em> <code>","</code> <code>-F "\"*,\"*"</code>,  menggunakan hasil dari poin a dengan mengoper variabel <code>region</code> ke dalam <code>awk</code> <code>-v a=${region[1]}</code>, melewati kolom header <code>FNR&gt;1</code>, jika wilayah bagian adalah wilayah bagian dari poin a <code>if($13~a)</code> maka digunakan <em>array</em> untuk mengelompokkan keuntungan berdasarkan negara bagian <code>u[$11]+=$NF</code>, dan menampilkan setiap elemen dari <em>array</em> tersebut beserta <em>value</em>-nya <code>for(i in u)printf "%6.4f %s \n", u[i], i</code>.</li>
<li>Mengurutkan keuntungan dari kecil ke besar menggunakan <code>sort</code> dan <code>-g</code> untuk mengurutkan secara <em>general numerik</em>.</li>
<li>Menampilkan dua baris pertama menggunakan <code>head -n2</code>.</li>
<li>Hasil yang berupa 2 negara bagian dengan keuntungan terkecil beserta keuntungannya disimpan pada variabel <code>state</code>.</li>
</ol>
<p><em><strong>c.</strong></em> 10 produk dengan keuntungan paling sedikit pada 2 negara bagian dari poin b</p>
<p><code>prod12=($(awk -F "\"*,\"*" -v a=${state[1]} -v b=${state[3]} 'FNR&gt;1{if($11~a||$11~b)u[$17]+=$NF}END{for(i in u)printf "%5.4f in %s\\n\n",u[i],i}' Sample-Superstore.csv | sort -g | head -n10 | nl -s"."))</code></p>
<ol>
<li>Mengolah <mark>Sample-Superstore.csv</mark> menggunakan <code>awk</code> dengan cara menentukan <em>field separator</em> <code>","</code> <code>-F "\"*,\"*"</code>,  menggunakan hasil dari poin b dengan mengoper variabel <code>state</code> ke dalam <code>awk</code> <code>-v a=${state[1]} -v b=${state[3]}</code>, melewati kolom header <code>FNR&gt;1</code>, jika negara bagian adalah negara bagian dari poin b <code>if($11~a||$11~b)</code> maka digunakan <em>array</em> untuk mengelompokkan keuntungan berdasarkan produk <code>u[$17]+=$NF</code>, dan menampilkan setiap elemen dari <em>array</em> tersebut beserta <em>value</em>-nya <code>for(i in u)printf "%5.4f in %s\\n\n",u[i],i</code>.</li>
<li>Mengurutkan keuntungan dari kecil ke besar menggunakan <code>sort</code> dan <code>-g</code> untuk mengurutkan secara <em>general numerik</em>.</li>
<li>Menampilkan sepuluh baris pertama menggunakan <code>head -n10</code>.</li>
<li>Menomori per baris menggunakan <code>nl</code> dan menambahkan titik setelah nomor <code>-s"."</code>.</li>
<li>Hasil yang berupa 10 produk dengan keuntungan terkecil beserta keuntungannya disimpan pada variabel <code>prod12</code>.</li>
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
<h4 id="penyelesaian-1">Penyelesaian</h4>
<p><strong>a.</strong> membuat sebuah script bash yang dapat menghasilkan password secara acak sebanyak 28 karakter yang terdapat huruf besar, huruf kecil, dan angka.</p>
<p><code>rand28=$(dd if=/dev/urandom | tr -dc a-zA-Z0-9 | fold -w 28 | awk '/[A-Z]/&amp;&amp;/[a-z]/&amp;&amp;/[0-9]/;a[$1]{for(i in a)print i}' | head -n1)</code></p>
<ol>
<li>Menampilkan /dev/urandom. Dalam sistem operasi mirip Unix, /dev/random, /dev/urandom dan /dev/arandom adalah file khusus yang berfungsi sebagai generator nomor pseudorandom. <a href="https://en.wikipedia.org/wiki//dev/random">Wikipedia</a>.</li>
<li>Menyaring hasil generator agar memiliki format alphanumerik <code>tr -dc 'a-zA-Z0-9'</code>.</li>
<li>Menyingkat menjadi 28 huruf per baris <code>fold -w 28</code>.</li>
<li>Menyaring baris agar memiliki minimal 1 huruf kapital, 1 huruf kecil, dan 1 angka menggunakan <code>awk</code>. <code>awk '/[A-Z]/&amp;&amp;/[a-z]/&amp;&amp;/[0-9]/;a[$1]{for(i in a)print i}'</code>.</li>
<li>Mengambil baris pertama <code>head -n 1</code>.</li>
<li>Disimpan ke variabel <code>rand28</code>.</li>
</ol>
<p><strong>b.</strong> Password acak tersebut disimpan pada file berekstensi .txt dengan nama berdasarkan argumen yang diinputkan dan HANYA berupa alphabet.</p>
<pre><code>file=$(echo $@)
file=$(echo ${file%%.*} | tr -dc 'a-zA-Z')
echo "$rand28" &gt; "$file.txt"
</code></pre>
<ol>
<li>Menyimpan argumen ke variabel <code>file</code>.</li>
<li>Memotong ekstensinya <code>echo ${file%%.*}</code>.</li>
<li>Menyaring agar tersisa hanya alphabet <code>tr -dc 'a-zA-Z'</code>.</li>
<li>Menyimpan hasil dari poin a ke file dengan nama berdasarkan argumen yang telah diproses. <code>echo "$rand28" &gt; "$file.txt"</code>.</li>
</ol>
<p><strong>c.</strong> Kemudian supaya file .txt tersebut tidak mudah diketahui maka nama filenya akan di enkripsi dengan menggunakan konversi huruf (string manipulation) yang disesuaikan dengan jam(0-23) dibuatnya file tersebut dengan program terpisah.</p>
<pre><code>#!/bin/bash
chr() { printf \\$(printf '%03o' $1); }
file=$(echo $@)
file=$(echo ${file%%.*} | tr -dc A-Za-z)
cr=$(sudo debugfs -R 'stat &lt;'"$(stat -c %i $file.txt)"'&gt;' "$(df --output=source $file.txt | tail -n1)" 2&gt;/dev/null | grep -oP 'crtime.*--\s*\K.*' | cut -c12-13)
if [[ $cr != 00 ]]; then
  shift=$(chr $(($cr + 65)))-ZA-$(chr $(($cr + 64)))$(chr $(($cr + 97)))-za-$(chr $(($cr + 96)))
  CC=$(echo $file | tr $shift A-Za-z)
  mv "$file.txt" "$CC.txt"
fi
</code></pre>
<ol>
<li>Fungsi “<em>chr</em>” digunakan untuk mengkonversi angka menjadi huruf sesuai dengan standar <em><strong>ASCII</strong></em>.</li>
<li>Menyimpan argumen ke variabel <code>file</code>.</li>
<li>Menghapus ekstensi dan karakter selain alfabet pada variabel <code>file</code>.</li>
<li>Mencari tahu kapan file dengan nama <code>file</code>.txt dibuat dengan menggunakan perintah <code>debugfs</code> untuk menemukan waktu pembuatan file, dengan <code>-R</code> yang menginstruksikan debugfs untuk mengeksekusi perintah eksternal tunggal lalu keluar yaitu <code>stat</code> dengan argumen <em>inode</em> dan <em>filesystem</em>. Nomor <em>inode</em> didapatkan dari hasil perintah <code>stat -c %i</code> terhadap file tersebut atau bisa juga dengan menggunakan perintah <code>ls -i</code> terhadap file tersebut. Kemudian untuk menemukan <em>filesystem</em> tempat file tersebut berada, cukup jalankan perintah <code>df --output=source</code> terhadap file tersebut untuk mengidentifikasi sistem filenya. Lalu kita ambil baris terakhir dari hasil perintah sebelumnya dengan <code>tail -n1</code>. Gunakan <code>2&gt;/dev/null</code> untuk menghilangkan error apa pun, . Hasil tersebut akan diambil tanggal dan waktu pembuatan filenya saja <code>crtime</code> menggunakan <code>grep -oP 'crtime.*--\s*\K.*'</code> Lalu dipotong jamnya saja <code>cut -c12-13</code> dan disimpan di variabel <code>cr</code><br>
d. Mengambil jam pembuatan dari  file <code>crtime</code>, disimpan di variabel <code>crhour</code>.</li>
<li>Mengecek apakah file dibuat diluar jam 0.<br>
a. Apabila file dibuat diluar jam 0, maka menggeser huruf <code>A(65)</code>, <code>@(64)</code>, <code>a(97)</code>, <code>`(96)</code> dengan <em>offset</em> <code>cr</code>,  disimpan sesuai format <code>(65+cr)-ZA-(64+cr)(97+cr)-za-(96+cr)</code> di variabel <code>shift</code>.<br>
b. Mentranslasi teks dari variabel <code>file</code> berdasarkan set pertama <code>A-Za-z</code> menjadi set kedua <code>shift</code>, dan hasilnya disimpan di variabel <code>CC</code>.<br>
c. Mengganti nama file dengan nama <code>file</code>.txt menjadi <code>CC</code>.txt .</li>
</ol>
<p><strong>d.</strong> jangan lupa untuk membuat dekripsinya supaya nama file bisa kembali.</p>
<ol>
<li>Mirip seperti poin c dengan pengecualian pada 5b dan 5c yaitu : 5b. menukar set pertama <code>A-Za-z</code> dan set kedua <code>shift</code>, dan hasilnya disimpan di variabel <code>dCC</code>.<br>
5c. Mengganti nama file dengan nama <code>file</code>.txt menjadi <code>dCC</code>.txt .</li>
</ol>
<h3 id="soal-3">Soal 3</h3>
<p>1 tahun telah berlalu sejak pencampakan hati Kusuma. Akankah sang pujaan hati kembali ke naungan Kusuma? Memang tiada maaf bagi Elen. Tapi apa daya hati yang sudah hancur, Kusuma masih terguncang akan sikap Elen. Melihat kesedihan Kusuma, kalian mencoba menghibur Kusuma dengan mengirimkan gambar kucing. [a] <mark>Maka dari itu, kalian mencoba membuat script untuk mendownload 28 gambar dari <a href="https://loremflickr.com/320/240/cat">https://loremflickr.com/320/240/cat</a>" menggunakan command wget dan menyimpan file dengan nama “pdkt_kusuma_NO” (contoh: pdkt_kusuma_1, pdkt_kusuma_2, pdkt_kusuma_3) serta jangan lupa untuk menyimpan log messages wget kedalam sebuah file “wget.log”.</mark> Karena kalian gak suka ribet, kalian membuat penjadwalan untuk menjalankan script download gambar tersebut. Namun, script download tersebut hanya berjalan[b] <mark>setiap 8 jam dimulai dari jam 6.05 setiap hari kecuali hari Sabtu</mark> Karena gambar yang didownload dari link tersebut bersifat random, maka ada kemungkinan gambar yang terdownload itu identik. Supaya gambar yang identik tidak dikira Kusuma sebagai spam, maka diperlukan sebuah script untuk memindahkan salah satu gambar identik. Setelah memilah gambar yang identik, maka dihasilkan gambar yang berbeda antara satu dengan yang lain. Gambar yang berbeda tersebut, akan kalian kirim ke Kusuma supaya hatinya kembali ceria. Setelah semua gambar telah dikirim, kalian akan<br>
selalu menghibur Kusuma, jadi gambar yang telah terkirim tadi akan kalian simpan kedalam folder /kenangan dan kalian bisa mendownload gambar baru lagi. [c] <mark>Maka dari itu buatlah sebuah script untuk mengidentifikasi gambar yang identik dari keseluruhan gambar yang terdownload tadi. Bila terindikasi sebagai gambar yang identik, maka sisakan 1 gambar dan pindahkan sisa file identik tersebut ke dalam folder ./duplicate<br>
dengan format filename “duplicate_nomor” (contoh : duplicate_200, duplicate_201). Setelah itu lakukan pemindahan semua gambar yang tersisa kedalam folder ./kenangan<br>
dengan format filename “kenangan_nomor” (contoh: kenangan_252, kenangan_253). Setelah tidak ada gambar di current directory, maka lakukan backup seluruh log menjadi<br>
ekstensi “.log.bak”.</mark><br>
<em>Hint : Gunakan wget.log untuk membuat location.log yang isinya<br>
merupakan hasil dari grep “Location”. Gunakan Bash, Awk dan Crontab</em></p>
<h4 id="penyelesaian-2">Penyelesaian</h4>
<p><img src="https://loremflickr.com/320/240/cat" alt="Cat"></p>
<p><strong>a.</strong> Maka dari itu, kalian mencoba membuat script untuk mendownload 28 gambar dari <a href="https://loremflickr.com/320/240/cat">https://loremflickr.com/320/240/cat</a>" menggunakan command wget dan menyimpan file dengan nama “pdkt_kusuma_NO” (contoh: pdkt_kusuma_1, pdkt_kusuma_2, pdkt_kusuma_3) serta jangan lupa untuk menyimpan log messages wget kedalam sebuah file “wget.log”.</p>
<pre><code>#!/bin/bash
rm wget.log 2&gt;/dev/null
for i in `seq 1 28`; do
  wget https://loremflickr.com/320/240/cat -O pdkt_kusuma_$i -a wget.log
done
</code></pre>
<ol>
<li>Menghapus wget.log bila ada.</li>
<li>Melakukan perulangan 28 kali <code>for i in `seq 1 28`</code> pada link yang telah disediakan untuk mengunduh gambar secara random <code>wget https://loremflickr.com/320/240/cat</code>.</li>
<li>Tidak lupa untuk mengganti namanya sesuai dengan urutan pengunduhan <code>-O pdkt_kusuma_$i</code> dan memasukkannya kedalam log <code>-a wget.log</code>.</li>
</ol>
<p><strong>b.</strong> Menjalankan script download gambar tersebut. Namun, script download tersebut hanya berjalan setiap 8 jam dimulai dari jam 6.05 setiap hari kecuali hari Sabtu</p>
<p><code>crontab -e</code> :</p>
<pre><code>5 6-23/8 * * 0-5 /&lt;path&gt;/soal3.sh
</code></pre>
<ol>
<li>Cron diatas <code>5 6-23/8 * * 0-5</code> dapat diartikan bahwa setiap 8 jam sekali yang dimulai pada pukul 6.05 akan dijalankan program <code>soal3.sh</code> <code>/&lt;path&gt;/soal3.sh</code>. Namun pada hari Sabtu tidak dijalankan pengunduhan sama sekali.</li>
<li>Jangan lupa mengganti permission agar bisa dieksekusi langsung <code>chmod +x</code> atau menambahkan <code>/bin/bash</code> sebelum file pada crontab.</li>
</ol>
<p><strong>c.</strong> Maka dari itu buatlah sebuah script untuk mengidentifikasi gambar yang identik dari keseluruhan gambar yang terdownload tadi. Bila terindikasi sebagai gambar yang identik, maka sisakan 1 gambar dan pindahkan sisa file identik tersebut ke dalam folder ./duplicate<br>
dengan format filename “duplicate_nomor” (contoh : duplicate_200, duplicate_201). Setelah itu lakukan pemindahan semua gambar yang tersisa kedalam folder ./kenangan<br>
dengan format filename “kenangan_nomor” (contoh: kenangan_252, kenangan_253). Setelah tidak ada gambar di current directory, maka lakukan backup seluruh log menjadi<br>
ekstensi “.log.bak”.</p>
<pre><code>#!/bin/bash
fix() {
  n=$(ls 2&gt;/dev/null -1 -- ./"$1"/"$1"_* | wc -l)
  for i in $2; do
    let n+=1
    mv $i "./$1/$1_$n"
  done
}
grep 'Location:' wget.log | cut -c32-53 | tr -d "_" &gt; location.log
a=($(paste "./location.log" &lt;(echo -e "pdkt_kusuma_"{1..28}"\n" | tr -d " ") | awk -F \\t '{a[$1]=$2}END{for(i in a)if(i)print a[i]}' | sort -k2))
b=($(ls pdkt_kusuma_* | sort))
c=()
for i in "${b[@]}"; do
    skip=
    for j in "${a[@]}"; do
        [[ $i == $j ]] &amp;&amp; { skip=1; break; }
    done
    [[ -n $skip ]] || c+=("$i")
done
mkdir -p duplicate kenangan
fix duplicate "${c[*]}"
fix kenangan "${a[*]}"
mv ./wget.log{,.bak}
</code></pre>
<ol>
<li>Fungsi <code>fix</code> :<br>
a. Menghitung jumlah file dengan nama yang berawalan dengan argumen pertama pada direktori memiliki nama yang sama dengan argumen pertama digabung garis bawah dengan cara <code>ls -1</code> untuk menampilkan isi direktori secara baris demi baris, <code>2&gt;/dev/null</code> untuk mengalihkan error, <code>--</code> sebagai pemisah antara opsi dan argumen, <code>wc -l</code> untuk menghitung jumlah baris, hasil hitungan disimpan di variabel <code>n</code>.<br>
b. Mengulang sejumlah elemen direpresentasikan oleh variabel <code>i</code> pada argumen kedua untuk menambah 1 pada variabel <code>n</code> dan memindah file dengan nama yang sama dengan variabel <code>i</code> ke direktori dengan nama yang sama dengan argumen pertama serta mengganti nama file tersebut menjadi sama seperti argumen pertama digabung garis bawah dan variabel <code>n</code>.</li>
<li>Mencari baris yang memiliki tulisan awal <code>Location:</code> pada wget.log <code>grep 'Location:' wget.log</code> kemudian dipotong pada karakter ke-32 hingga karakter ke-53 <code>cut -c32-53</code> yang mana merupakan nomor seri pada nama file di URL file tersebut  dan menghilangkan garis bawah <code>tr -d "_"</code> untuk mempermudah pengurutan lalu disimpan sebagai <code>location.log</code>.</li>
<li>Menampilkan isi <code>location.log</code> lalu menempelkan <code>pdkt_kusuma_NO</code>dengan nomor 1 - 28 di setiap baris di belakangnya. Menghilangkan baris dengan nomor seri yang sama menggunakan <code>awk</code> <code>a[$1]=$2</code> dan menghilangkan baris kosong <code>if(i)</code> dan mengurutkan hasilnya <code>sort -k2</code> disimpan di variabel <code>a</code>.</li>
<li>Melakukan pengurutan file dengan nama yang dimulai dengan <code>pdkt_kusuma_</code> pada direktori <code>ls pdkt_kusuma_*</code> kemudian diurutkan <code>sort</code> dan disimpan sebagai variabel <code>b</code> yang akan berfungsi sebagai referensi.</li>
<li>Membuat array kosong bernama <code>c</code>. <code>c=()</code>.</li>
<li>Membandingkan <code>a</code> dengan <code>b</code> dan menyimpan elemen yang ada di <code>b</code> namun tidak ada di <code>a</code> ke <code>c</code> dengan cara membuat perulangan untuk setiap elemen dalam <code>b</code>,  <code>for i in "${b[@]}"</code> membuat variabel <code>skip</code> dengan nilai 0, <code>skip=</code> dan membuat perulangan untuk setiap elemen dalam <code>a</code>, <code>for j in "${a[@]}"for j in "${a[@]}"</code>, apabila elemen dalam <code>a</code> dan <code>b</code> sama, maka mengganti nilai <code>skip</code> menjadi 1, <code>[[ $i == $j ]]</code> <code>skip=1</code> dan keluar dari perulangan elemen <code>a</code>, <code>break</code>. Apabila nilai <code>skip</code> masih 0 ketika perulangan elemen <code>a</code> selesai, <code>[[ -n $skip ]]</code> maka elemen tersebut dimasukkan ke <code>c</code>, <code>c+=("$i")</code>.</li>
<li>Membuat direktori “duplicate” dan “kenangan” apabila tidak ada, <code>mkdir -p duplicate kenangan</code>.</li>
<li>Memanggil fungsi <code>fix</code> dengan argumen <code>duplicate</code> dan <code>"${c[*]}"</code>.</li>
<li>Memanggil fungsi <code>fix</code> dengan argumen <code>kenangan</code> dan <code>"${a[*]}"</code>.</li>
<li>Terakhir mencadangkan log, <code>mv ./wget.log{,.bak}</code>.</li>
</ol>