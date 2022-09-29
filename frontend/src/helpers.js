export async function connect(){
    try{
        const accounts = await window.ethereum.request({ method: "eth_requestAccounts" });
        const account = handleAccountChange(accounts);
        return account;
    }catch(error){
        if(error.code == 4001) 
            alert("Please connect to metamask to continue");
        else
            console.log(error);
    }
}

function handleAccountChange(accounts){
    if(accounts.length === 0)
        alert("Please connect to metamask to continue");
    else{
        window.ethereum.on("accountsChanged", () => { window.location.reload() });
        return accounts[0];
    }
}