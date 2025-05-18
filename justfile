deploy:
  sam build
  sam deploy

  aws cloudformation wait stack-update-complete --stack-name pi-streaming

raspberry-install:
  ./raspberry_pi_setup.sh

run:
  gst-launch-1.0 libcamerasrc ! \
    video/x-raw,format=NV12,width=1280,height=720,framerate=30/1 ! \
    v4l2h264enc output-io-mode=4 ! \
    h264parse ! \
    kvssink stream-name="RaspberryPiStream" \
    aws-region="eu-west-1" \
    iot-certificate="iot-certificate,endpoint=c2hvqkfjjgz92x.credentials.iot.aws-region.amazonaws.com,cert-path=./certs/certificate.pem,key-path=./certs/private.pem.key,ca-path=./certs/cacert.pem,role-aliases=IoTRoleAlias,iot-thing-name=RaspberryPiThing"