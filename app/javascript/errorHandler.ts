export default (err: unknown | Error, instance: unknown = 'this', info: string = 'info') => {
  const errorsUrl = `https://api.telegram.org/bot${import.meta.env.VITE_TG_KEY}/sendMessage`
  fetch(errorsUrl, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      chat_id: import.meta.env.VITE_TG_CHAT_ID,
      text: `Error: ${err?.message} \n\n Instance: ${instance} \n\n Info: ${info} \n\n Stack: ${err?.stack}`
    })
  })
}
