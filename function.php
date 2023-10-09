<?php 
session_start();

// Membuat koneksi ke database
$conn = mysqli_connect("localhost","root","","stockbarang");


// Menambah Barang Baru
if(isset($_POST['addnewbarang'])){
    $namabarang = $_POST['namabarang'];
    $deskripsi = $_POST['deskripsi'];
    $stock = $_POST['stock'];

    // soal gambar
    $allowed_extension = array('png','jpg');
    $nama = $_FILES['file']['name']; //ngambil nama gambar
    $dot = explode('.',$nama);
    $ekstensi = strtolower(end($dot)); //ngambil ekstensinya
    $ukuran = $_FILES['file']['size']; //ngambil size filenya
    $file_tmp = $_FILES['file']['tmp_name']; //ngambil lokasi filenya

    // penamaan file -> enkripsi
    $image = md5(uniqid($nama,true) . time()).'.'.$ekstensi; //menggabungkan nama file yg dienkripsi dgn ekstensinya

    // validasi udah ada atau belum
    $cek = mysqli_query($conn,"select * from stock where namabarang='$namabarang'");
    $hitung = mysqli_num_rows($cek);

    if($hitung<1){
        // jika belum ada
        
        // proses upload gambar
        if(in_array($ekstensi, $allowed_extension) === true){
            //validasi ukuran filenya
            if($ukuran < 15000000){
                move_uploaded_file($file_tmp, 'images/'.$image);

                $addtotable = mysqli_query($conn,"insert into stock (namabarang, deskripsi, stock, image) values('$namabarang','$deskripsi','$stock','$image')");
                if($addtotable){
                    header('location:index.php');
                } else {
                    echo 'Gagal';
                    header('location:index.php');
                }
            } else {
                // kalau filenya lebih dari 15mb
                echo '
                <script>
                    alert("Ukuran terlalu besar");
                    window.location.href="index.php"; 
                </script>
                ';
            }
        } else {
            //kalau filenya tidak png / jpg
            echo '
                <script>
                    alert("File harus png/jpg");
                    window.location.href="index.php"; 
                </script>
                ';
        }

    } else {
        // jika sudah ada
        echo '
        <script>
            alert("Nama barang sudah terdaftar");
            window.location.href="index.php"; 
        </script>
        ';
    }

    
};

// Menambah barang masuk
if(isset($_POST['barangmasuk'])){
    $barangnya = $_POST['barangnya'];
    $penerima = $_POST['penerima'];
    $qty = $_POST['qty'];

    $cekstocksekarang = mysqli_query($conn,"select * from stock where idbarang='$barangnya'");
    $ambildatanya = mysqli_fetch_array($cekstocksekarang);

    $stocksekarang = $ambildatanya['stock'];
    $tambahkanstocksekarangdenganquantity = $stocksekarang+$qty;

    $addtomasuk = mysqli_query($conn,"insert into masuk (idbarang, keterangan, qty) values('$barangnya','$penerima','$qty')");
    $updatestockmasuk = mysqli_query($conn,"update stock set stock='$tambahkanstocksekarangdenganquantity' where idbarang='$barangnya'");
    if($addtomasuk&&$updatestockmasuk){
        header('location:masuk.php');
    } else {
        echo 'Gagal';
        header('location:masuk.php');
    }
}


// Menambah barang keluar
if(isset($_POST['addbarangkeluar'])){
    $barangnya = $_POST['barangnya'];
    $penerima = $_POST['penerima'];
    $qty = $_POST['qty'];

    $cekstocksekarang = mysqli_query($conn,"select * from stock where idbarang='$barangnya'");
    $ambildatanya = mysqli_fetch_array($cekstocksekarang);

    $stocksekarang = $ambildatanya['stock'];


    if($stocksekarang >= $qty){
        // kalau barangnya cukup
        $tambahkanstocksekarangdenganquantity = $stocksekarang-$qty;

        $addtokeluar = mysqli_query($conn,"insert into keluar (idbarang, penerima, qty) values('$barangnya','$penerima','$qty')");
        $updatestockmasuk = mysqli_query($conn,"update stock set stock='$tambahkanstocksekarangdenganquantity' where idbarang='$barangnya'");
        if($addtokeluar&&$updatestockmasuk){
            header('location:keluar.php');
        } else {
            echo 'Gagal';
            header('location:keluar.php');
        }
    } else {
        // kalau barangnya gak cukup
        echo '
        <script>
            alert("Stock saat ini tidak mencukupi");
            window.location.href="keluar.php";
        </script>
        ';
    }
}


// Update info barang
if(isset($_POST['updatebarang'])){
    $idb = $_POST['idb'];
    $namabarang = $_POST['namabarang'];
    $deskripsi = $_POST['deskripsi'];

    // soal gambar
    $allowed_extension = array('png','jpg');
    $nama = $_FILES['file']['name']; //ngambil nama gambar
    $dot = explode('.',$nama);
    $ekstensi = strtolower(end($dot)); //ngambil ekstensinya
    $ukuran = $_FILES['file']['size']; //ngambil size filenya
    $file_tmp = $_FILES['file']['tmp_name']; //ngambil lokasi filenya

    // penamaan file -> enkripsi
    $image = md5(uniqid($nama,true) . time()).'.'.$ekstensi; //menggabungkan nama file yg dienkripsi dgn ekstensinya

    if($ukuran==0){
        //jika tidak ingin upload
        $update = mysqli_query($conn,"update stock set namabarang='$namabarang', deskripsi='$deskripsi' where idbarang = '$idb'");
        if($update){
            header('location:index.php');
        } else {
            echo 'Gagal';
            header('location:index.php');
        }
    } else {
        //jika ingin
        move_uploaded_file($file_tmp, 'images/'.$image);
        $update = mysqli_query($conn,"update stock set namabarang='$namabarang', deskripsi='$deskripsi', image='$image' where idbarang = '$idb'");
        if($update){
            header('location:index.php');
        } else {
            echo 'Gagal';
            header('location:index.php');
        }
    }
}


// Menghapus barang dari stock
if(isset($_POST['hapusbarang'])){
    $idb = $_POST['idb']; //idbarang

    $gambar = mysqli_query($conn,"select * from stock where idbarang='$idb'");
    $get = mysqli_fetch_array($gambar);
    $img = 'images/'.$get['image'];
    unlink($img);

    $hapus = mysqli_query($conn, "delete from stock where idbarang='$idb'");
    if($hapus){
        header('location:index.php');
    } else {
        echo 'Gagal';
        header('location:index.php');
    }
};

// Mengubah data barang masuk
if(isset($_POST['updatebarangmasuk'])){
    $idb = $_POST['idb'];
    $idm = $_POST['idm'];
    $deskripsi = $_POST['keterangan'];
    $qty = $_POST['qty'];

    $lihatstock = mysqli_query($conn,"select * from stock where idbarang='$idb'");
    $stocknya = mysqli_fetch_array($lihatstock);
    $stockskrg = $stocknya['stock'];

    $qtyskrg = mysqli_query($conn, "select * from masuk where idmasuk='$idm'");
    $qtynya = mysqli_fetch_array($qtyskrg);
    $qtyskrg = $qtynya['qty'];

    if($qty>$qtyskrg){
        $selisih = $qty-$qtyskrg;
        $kurangin = $stockskrg - $selisih;
        $kurangistocknya = mysqli_query($conn, "update stock set stock='$kurangin' where idbarang='$idb'");;
        $updatenya = mysqli_query($conn,"update masuk set qty='$qty', keterangan='$deskripsi' where idmasuk='$idm'");
            if($kurangistocknya&&$updatenya){
                header('location:masuk.php');
                } else {
                    echo 'Gagal';
                    header('location:masuk.php');
            }
    } else {
        $selisih = $qtyskrg-$qty;
        $kurangin = $stockskrg + $selisih;
        $kurangistocknya = mysqli_query($conn, "update stock set stock='$kurangin' where idbarang='$idb'");;
        $updatenya = mysqli_query($conn,"update masuk set qty='$qty', keterangan='$deskripsi' where idmasuk='$idm'");
            if($kurangistocknya&&$updatenya){
                header('location:masuk.php');
                } else {
                    echo 'Gagal';
                    header('location:masuk.php');
            }
    }

}


// Menghapus barang masuk
if(isset($_POST['hapusbarangmasuk'])){
    $idb = $_POST['idb'];
    $qty = $_POST['kty'];
    $idm = $_POST['idm'];

    $getdatastock = mysqli_query($conn,"select * from stock where idbarang='$idb'");
    $data = mysqli_fetch_array($getdatastock);
    $stok = $data['stock'];

    $selisih = $stok-$qty;

    $update = mysqli_query($conn,"update stock set stock='$selisih' where idbarang='$idb'");
    $hapusdata = mysqli_query($conn,"delete from masuk where idmasuk='$idm'");

    if($update&&$hapusdata){
        header('location:masuk.php');
    } else {
        header('location:masuk.php');
    }
}

// Mengubah data barang keluar
if(isset($_POST['updatebarangkeluar'])){
    $idb = $_POST['idb'];
    $idk = $_POST['idk'];
    $penerima = $_POST['penerima'];
    $qty = $_POST['qty'];

    $lihatstock = mysqli_query($conn,"select * from stock where idbarang='$idb'");
    $stocknya = mysqli_fetch_array($lihatstock);
    $stockskrg = $stocknya['stock'];

    $qtyskrg = mysqli_query($conn, "select * from keluar where idkeluar='$idk'");
    $qtynya = mysqli_fetch_array($qtyskrg);
    $qtyskrg = $qtynya['qty'];

    if($qty>$qtyskrg){
        $selisih = $qty-$qtyskrg;
        $kurangin = $stockskrg - $selisih;
        $kurangistocknya = mysqli_query($conn, "update stock set stock='$kurangin' where idbarang='$idb'");;
        $updatenya = mysqli_query($conn,"update keluar set qty='$qty', penerima='$penerima' where idkeluar='$idk'");
            if($kurangistocknya&&$updatenya){
                header('location:keluar.php');
                } else {
                    echo 'Gagal';
                    header('location:keluar.php');
            }
    } else {
        $selisih = $qtyskrg-$qty;
        $kurangin = $stockskrg + $selisih;
        $kurangistocknya = mysqli_query($conn, "update stock set stock='$kurangin' where idbarang='$idb'");;
        $updatenya = mysqli_query($conn,"update keluar set qty='$qty', penerima='$penerima' where idkeluar='$idk'");
            if($kurangistocknya&&$updatenya){
                header('location:keluar.php');
                } else {
                    echo 'Gagal';
                    header('location:keluar.php');
            }
    }

}

// Menghapus barang keluar
if(isset($_POST['hapusbarangkeluar'])){
    $idb = $_POST['idb'];
    $qty = $_POST['kty'];
    $idk = $_POST['idk'];

    $getdatastock = mysqli_query($conn,"select * from stock where idbarang='$idb'");
    $data = mysqli_fetch_array($getdatastock);
    $stok = $data['stock'];

    $selisih = $stok+$qty;

    $update = mysqli_query($conn,"update stock set stock='$selisih' where idbarang='$idb'");
    $hapusdata = mysqli_query($conn,"delete from keluar where idkeluar='$idk'");

    if($update&&$hapusdata){
        header('location:keluar.php');
    } else {
        header('location:keluar.php');
    }
}

// Menambah Admin Baru
if(isset($_POST['addadmin'])){
    $email = $_POST['email'];
    $password = $_POST['password'];

    $queryinsert = mysqli_query($conn,"insert into login (email, password) values ('$email','$password')");

    if($queryinsert){
        // if berhasil
        header('location:admin.php');
    } else {
        // kalau gagal insert ke db
        header('location:admin.php');
    }
}

// Edit data admin
if(isset($_POST['updateadmin'])){
    $emailbaru = $_POST['emailadmin'];
    $passwordbaru = $_POST['passwordbaru'];
    $idnya = $_POST['id'];

    $queryupdate = mysqli_query($conn,"update login set email='$emailbaru', password='$passwordbaru' where iduser='$idnya'");

    if($queryupdate){
        header('location:admin.php');
    } else {
        header('location:admin.php');
    }
}

// Hapus admin
if(isset($_POST['hapusadmin'])){
    $id = $_POST['id'];

    $querydelete = mysqli_query($conn,"delete from login where iduser='$id'");

    if($querydelete){
        header('location:admin.php');
    } else {
        header('location:admin.php');
    }
}

function registrasi($data){
    global $conn;

    $email = strtolower(stripslashes($data["email"]));
    $password = mysqli_real_escape_string($conn, $data["password"]);
    $password2 = mysqli_real_escape_string($conn, $data["password2"]);

    // cek email sudah ada atau belum
    $result = mysqli_query($conn, "SELECT email FROM user WHERE email = '$email'");

    if( mysqli_fetch_assoc($result) ) {
        echo "<script>
                alert('email sudah terdaftar!')
            </script>";
        return false;
    }

    // cek konfirmasi password
    if( $password !== $password2 ) {
        echo "<script>
                alert('konfirmasi password tidak sesuai!');
            </script>";
        return false;
    }
    // enkripsi password
    $password = password_hash($password, PASSWORD_DEFAULT);

    // tambahkan userbaru ke database
    mysqli_query($conn, "INSERT INTO user VALUES('', '$email', '$password')");
    
    return mysqli_affected_rows($conn);
}
?>