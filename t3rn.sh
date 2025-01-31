#!/bin/bash

# 환경 변수 설정
export WORK="/root/Bridge-et1rn"
export NVM_DIR="$HOME/.nvm"

# 색상 정의
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # 색상 초기화

echo -e "${GREEN}T3RN 봇을 설치합니다.${NC}"
echo -e "${GREEN}스크립트작성자: https://t.me/kjkresearch${NC}"
echo -e "${GREEN}출처: https://github.com/AirdropFamilyIDN-V2-0/Bridge-et1rn.git${NC}"
echo -e "${GREEN}BASE Sepolia, OP Sepolia ETH가 필요합니다.${NC}"
read -p "최소 트랜잭션 ETH는 0.1개입니다. 엔터를 눌러서 진행하세요"

echo -e "${GREEN}설치 옵션을 선택하세요:${NC}"
echo -e "${YELLOW}1. T3RN 봇 새로 설치${NC}"
echo -e "${YELLOW}2. 재실행하기${NC}"
read -p "선택: " choice

case $choice in
  1)
    echo -e "${GREEN}T3RN 봇을 새로 설치합니다.${NC}"

    # 사전 필수 패키지 설치
    echo -e "${YELLOW}시스템 업데이트 및 필수 패키지 설치 중...${NC}"
    sudo apt update
    sudo apt install -y git

    echo -e "${YELLOW}작업 공간 준비 중...${NC}"
    if [ -d "$WORK" ]; then
        echo -e "${YELLOW}기존 작업 공간 삭제 중...${NC}"
        rm -rf "$WORK"
    fi

    # GitHub에서 코드 복사
    echo -e "${YELLOW}GitHub에서 코드 복사 중...${NC}"
    git clone https://github.com/AirdropFamilyIDN-V2-0/Bridge-et1rn.git
    cd "$WORK"

 # 파이썬 및 필요한 패키지 설치
    echo -e "${YELLOW}시스템 업데이트 및 필수 패키지 설치 중...${NC}"
    sudo apt update
    sudo apt install -y python3 python3-pip
    pip install -r requirements.txt
    pip install web3==6.20.1
    pip install eth-abi==5.1.0
    pip install colorama==0.4.6
    pip install requests==2.32.3

    echo -e "${YELLOW}Civil을 피하기 위해 다계정 개수만큼 개인키와 프록시가 필요합니다.${NC}"
    echo -e "${GREEN}여러 개의 개인키를 줄바꿈으로 구분하세요.${NC}"
    echo -e "${GREEN}입력을 마치려면 엔터를 두 번 누르세요.${NC}"
    
    # 개인키 파일 생성 및 초기화
    {
        while IFS= read -r line; do
            [[ -z "$line" ]] && break
            echo "$line"
        done
    } > "$WORK/updatev6/pvkeylist.txt"

    # 사용자에게 프록시 사용 여부를 물어봅니다.
    read -p "프록시를 사용하시겠습니까? (y/n): " use_proxy
    
    if [[ "$use_proxy" == "y" || "$use_proxy" == "Y" ]]; then
        # 프록시 정보 입력 안내
        echo -e "${YELLOW}프록시 정보를 입력하세요. 입력형식: http://user:pass@ip:port${NC}"
        echo -e "${GREEN}여러 개의 프록시는 줄바꿈으로 구분하세요.${NC}"
        echo -e "${GREEN}입력을 마치려면 엔터를 두 번 누르세요.${NC}"

        # 프록시 정보를 직접 proxy.txt 파일에 저장
        > "$WORK/proxy.txt"  # 파일 초기화
        while IFS= read -r line; do
            [[ -z "$line" ]] && break
            echo "$line" >> "$WORK/pakeproxy/proxy.txt"
        done

        echo -e "${GREEN}프록시 정보가 proxy.txt 파일에 저장되었습니다.${NC}"

        # 봇 구동
        pip install -r requirements.txt
        cd "$WORK"/updatev6
        python3 t1rnmultiv6_auto.py
    else
        cd "$WORK"/updatev6
        python3 t1rnmultiv6_auto.py
    fi
    ;;
    
  2)
    echo -e "${GREEN}t3rn 봇을 재실행합니다.${NC}"

    # 봇 구동
    cd "$WORK"/updatev6
    pip install -r requirements.txt
    python3 t1rnmultiv6_auto.py
    ;;

  *)
    echo -e "${RED}잘못된 선택입니다. 다시 시도하세요.${NC}"
    ;;
esac
