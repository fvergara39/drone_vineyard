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

## 2) Registrazione e riproduzione dei dati
- Posizionarsi, da terminale, nella cartella in cui sono salvati i bagfiles. Dopodichè se si vuole visualizzare su rviz:
     ```
        roslaunch rplidar_ros recorded.launch
     ```
 Se si vuole solo riprodurre la registrazione senza l'utilizzo di rviz :
     ```
        roscore 
     ```
 In un nuovo terminale, digitare 
     ```
	rosparam set use_sim_time true
        rosbag play -l <bagfilename.bag> --clock 
     ```
 -l se si vuole la riproduzione in loop

- Se si volesse procedere ad una nuova raccolta dati, è opportuno assicurarsi di avere i due pacchetti dei sensori. E' possibile
trovarli nella stessa cartella di README.md , o scaricarli come segue :
     ```
        ~/catkin_ws/src:
        git clone AGGIUNGI DA UBUNTU
        git clone AGGIUNGI DA UBUNTU
     ```
Dopodichè posizionarsi da terminale nella cartella 'bagfiles' del proprio catkin wokspace, quindi lanciare i comandi 
     ```
        ~/catkin_ws/bagfiles:
	roslaunch realsense2_camera rs_camera.launch
	roslaunch rplidar_ros rplidar_s1.launch
	roslaunch rplidar_ros recorded.launch
	rosbag record <bagfilename.bag>
     ```
L'esecuzione di 'recorded.launch' è facoltativa e al solo scopo di essere di supporto durante la registrazione.

## 3) Analisi dati 
- Scaricare la cartella drone_Vineyard se non lo si è fatto precedentemente. Per riprodurre i risultati mostrati nei lucidi, utilizzare i dati in scanData.mat 
e pointData.mat. salvati nella cartella 'data'.
- Qualora si volessero usare altri dati sperimentali, aprire il file 'im_rosbag' nella cartella 'utilities' e modificare il percorso del bagfile
che si vuole utilizzare. Quindi eseguire. 
- Eventualmente, modificare il nome con cui vengono salvate le strutture di dati, in modo da non sovrascrivere quelle preesistenti.

### 3.1) Analisi dati - LiDAR
- Aprire il file main_Lidar.m ed eseguire la prima sezione dello script.
- E' pssibile modificare il campo di vista su cui si visualizzano i dati, modificando gli angoli in ingresso alla funzione 'scans_profile'. 

### 3.2) Analisi dati - Camera
- Per riprodurre i risultati ottenuti circa il profilo medio dei filari con la Realsense Camera D435i, aprire il file main_Camera.m ed eseguire.
- Se si vuole osservare come varia la Pointcloud3D durante la registrazione, eseguire show_pclouds.m

## 4) Controllo
- Per la valutazione della posizione del drone (plot e creazione della variabile 'correction'), aprire lo script main_Lidar.m e settare la variabile
 geomMethod a 1 se si vuole usare il metodo geometrico ; settare geomMethod a 0 se si vuole usare il metodo con kmeans.

- Se durante la computazione, oltre alla visualizzazione dei dati già allineati all'orizzonte, si vogliono plottare anche i dati originali, cambiare il valore 
della variabile drawPlot nello script <metodo>_positionCheck.m e settarla a 1.
