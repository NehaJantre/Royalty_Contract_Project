npm install web3
import os
import json
from web3 import Web3
from pathlib import Path
from dotenv import load_dotenv
import streamlit as st
#var Web3 = require("web3")

load_dotenv()

w3 = Web3(Web3.HTTPProvider(os.getenv("WEB3_PROVIDER_URI")))
# print(w3)
@st.cache(allow_output_mutation=True)
def load_contract():
    with open(Path('./contracts/compiled/PaymentSplitterFinal.json')) as f:
        paymentsplitter_abi = json.load(f)

    contract_address = os.getenv("SMART_CONTRACT_ADDRESS")

    contract = w3.eth.contract(
        address=contract_address,
        abi=paymentsplitter
    )

    return contract

    contract = load_contract()

st.header("smart contract address")
st.write("0x1258Ad7A0519b9f28bAf34c76AA99F91d3A37ddb")

    #st.title("Use crypto to buy physical Product")
accounts = w3.eth.accounts
# print(accounts)
address = st.selectbox("input address", options=accounts)
#find the balance of the account
account_balance = w3.eth.get_balance(address)
print(account_balance)
# print(dir(w3))
# print("-------")
# print(dir(w3.eth))
# print("-------")
# print(w3.eth.get_balance('0xF2F4A5eC3356F9B539d4d6f30336178d86C5f6Cf')) // 99971541600000000000
# print("-------")
# print(w3.eth.balance)//'0xF2F4A5eC3356F9B539d4d6f30336178d86C5f6Cf'
paymentsplitter = st.number_input("The amount of ETH")
print(paymentsplitter)

#would this work for above paymentsplitter = st.number_input.web3.toEth("The amount of ETH")

web3.eth.send_transaction({
  'to': '0x1258Ad7A0519b9f28bAf34c76AA99F91d3A37ddb',
  'from': accounts,
  'value': paymentsplitter,
  'gas': 21000,
  'maxFeePerGas': web3.toWei(250, 'gwei'),
  'maxPriorityFeePerGas': web3.toWei(2, 'gwei'),
})



#tx_hash = 0
if(paymentsplitter <= account_balance):    
    if st.button("confirm transaction"):
        print("good")
        tx_hash
        #tx_hash = contract.functions.registerArtwork(address, paymentsplitter).transact({
         #"from": address,
         #"gas": 1000000})

else:
    # st.message("Not sufficient Balance!")
    st.write("Not sufficient balance!")
    print("not ")


receipt = w3.eth.waitForTransactionReceipt(tx_hash)
st.write("Transaction receipt mined:")
st.write(dict(receipt))




##goal is:  
# 1) input customers address  
# 2) hardcode smart contract address 
# 3) input amount customer wants to send and then 
# 4) confirm button.