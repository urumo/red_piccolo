export default (err: Error, instance: unknown, info: string) => {
  if (!import.meta.env.VITE_TG_KEY || !import.meta.env.VITE_TG_CHAT_ID) {
    console.error('Telegram bot key or chat ID is not set.');
    return;
  }
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
