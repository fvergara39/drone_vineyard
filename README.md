# drone_vineyard
# Controllo della posizione di un drone lungo due filari 

## Contenuti:
* [1. Requisiti](#1-requisiti)
* [2. Registrazione e riproduzione dei dati](#2-registrazione-e-riproduzione-dei-dati)
* [3. Analisi dati](#3-analisi-dati)
* [4. Controllo](#3-controllo)

## 1) Requisiti
- Per poter riprodurre i bagfiles bisogna operare sul sistema operativo Ubuntu. 
- Se si volesse procedere ad una nuova raccolta dati, è necessario avere a disposizione una porta USB3 per il collegamento della camera Intel Realsense.
- NB. La registrazione è stata effettuata su Ubuntu 18.04 e ROSDistro Melodic. per eventuali propblemi di compatibilità tra i dispositivi e la ROSDistro, consultare la documentazione ufficiale dei sensori.
- Per l'analisi dei dati e la stima della posizione, è stato usato MATLAB 2021b.

## 2) Registrazione e riproduzione dei dati
### 2.1) Riproduzione dei dati
- Posizionarsi, da terminale, nella cartella in cui sono salvati i bagfiles. Dopodichè se si vuole visualizzare su rviz:
     ```
        roslaunch rplidar_ros recorded.launch
     ```
- Se invece si vuole solo riprodurre la registrazione senza l'utilizzo di rviz, al posto di 'recorded.launch', lanciare  :
     ```
        roscore 
     ```
- Per entrambi i casi, in un nuovo terminale, digitare 
     ```
	rosparam set use_sim_time true
        rosbag play -l <bagfilename.bag> --clock 
     ```
 (-l se si vuole la riproduzione in loop)

### 2.2) Registrazione di nuovi dati
- Se si volesse procedere ad una nuova raccolta dati, è opportuno assicurarsi di avere i due pacchetti dei sensori. E' possibile
trovarli nella stessa cartella di README.md , o scaricarli come segue :
     ```
        ~/catkin_ws/src:
        git clone https://github.com/Slamtec/rplidar_ros.git
        git clone https://github.com/IntelRealSense/realsense-ros.git
     ```
- Per il pacchetto rplidar_ros, aggiungere nel file di launch rplidar_s1.launch il seguente :
     ```
     <node pkg="tf" type="static_transform_publisher" name="map_laser_broadcaster" args="0 0 0 0 3.14 3.14 camera_link laser 100" />
     ```
- Per il pacchetto realsense2_camera, mettere a 'true' il parametro "enable_pointcloud" e "ordered_pc" del file di launch rs_camera.launch.
- Aggiungere nella cartella 'launch' di rplidar_ros, il file recorded.launch presente nella cartella 'ros' di drone_vineyard e il file exp_cfg.rviz nella cartella 'rviz' di rplidar_ros.
- Da terminale ritornare nel catkin workspace ed eseguire catkin_make.
- Dopodichè posizionarsi da terminale nella cartella 'bagfiles' del proprio catkin wokspace, ove si vogliono salvare le registrazione. Quindi lanciare i comandi 
     ```
        ~/catkin_ws/bagfiles:
	roslaunch realsense2_camera rs_camera.launch
	roslaunch rplidar_ros rplidar_s1.launch
	roslaunch rplidar_ros recorded.launch
	rosbag record -O <bagfilename.bag>
     ```
( L'esecuzione di 'recorded.launch' è facoltativa e al solo scopo di essere di supporto durante la registrazione.)

## 3) Analisi dati su MATLAB
- Nel caso in cui non si disponesse della cartella drone_vineyard, scaricarla dal link https://github.com/fvergara39/drone_vineyard.git.
- Per riprodurre i risultati mostrati nei lucidi, utilizzare i dati in scanData.mat e pointData.mat. salvati nella cartella 'data'.
- Qualora si volessero usare altri dati sperimentali, aprire il file 'im_rosbag' nella cartella 'utilities' e modificare il percorso del bagfile
che si vuole utilizzare. Quindi eseguire. 
- Eventualmente, modificare il nome con cui vengono salvate le strutture di dati, in modo da non sovrascrivere quelle preesistenti.
- Se si utilizzano altri dati, modificare il caricamento dei dati all'inizio degli script main_Lidar.m , main_Camera.m, drone_pov.m, spatial_pov.m.

### 3.1) Analisi dati - LiDAR
- Per riprodurre solo i risultati ottenuti circa il profilo medio dei filari con SLAMTEC rplidar s1, aprire il file main_Lidar.m ed eseguire la prima sezione dello script.
- E' pssibile modificare il campo di vista su cui si visualizzano i dati, modificando gli angoli in ingresso alla funzione 'scans_profile'. 

### 3.2) Analisi dati - Camera
- Per riprodurre solo i risultati ottenuti circa il profilo medio dei filari con la Realsense Camera D435i, aprire il file main_Camera.m ed eseguire la prima sezione dello script.
- Se si vuole osservare la Pointcloud3D durante la registrazione, eseguire show_pclouds.m ( seconda sezione di main_Camera.m).

## 4) Controllo
- Per la valutazione della posizione del drone (plot e creazione della variabile 'correction'), aprire lo script main_Lidar.m e settare la variabile
 geomMethod = 1 se si vuole usare il metodo geometrico ; settare geomMethod = 0 se si vuole usare il metodo con kmeans.

- Se durante la computazione, oltre alla visualizzazione dei dati già allineati all'orizzonte, si vogliono plottare anche i dati originali, cambiare il valore 
della variabile drawPlot nello script <metodo>_positionCheck.m e settarla a 1.
	
	Per maggiori dettagli, si rimanda ai lucidi presenti nella cartella drone_vineyard.
