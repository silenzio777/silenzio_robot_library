



CycloneDDS
```
<?xml version="1.0" encoding="UTF-8"?>
<CycloneDDS
    xmlns="https://cdds.io/config"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="https://cdds.io/config https://raw.githubusercontent.com/eclipse-cyclonedds/cyclonedds/master/etc/cyclonedds.xsd">
  <Domain id="0">
    <General>
      <Interfaces>
        <NetworkInterface name="enp6s0" />
      </Interfaces>
      <AllowMulticast>false</AllowMulticast>
      <MaxMessageSize>65500B</MaxMessageSize>
    </General>

    <Discovery>
      <ParticipantIndex>auto</ParticipantIndex>
      <MaxAutoParticipantIndex>50</MaxAutoParticipantIndex>
      <Peers>
        <Peer Address="192.168.2.29"/>  <!-- Jetson Nano -->
        <Peer Address="192.168.2.37"/>  <!-- Jetson Orin NX -->
        <Peer Address="192.168.2.41"/>  <!-- Ubuntu PC x86 -->
      </Peers>
    </Discovery>

    <Internal>
      <Watermarks>
        <WhcHigh>500kB</WhcHigh>
      </Watermarks>
    </Internal>
  </Domain>
</CycloneDDS>
```
