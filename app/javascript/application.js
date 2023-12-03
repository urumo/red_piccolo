// Entry point for the build script in your package.json
import '@hotwired/turbo-rails'
import './controllers'
import './channels'

document.addEventListener('DOMContentLoaded', () => {
  ;(document.querySelectorAll('.notification .delete') || []).forEach(($delete) => {
    const $notification = $delete.parentNode

    $delete.addEventListener('click', () => {
      setTimeout(() => {
        $notification.parentNode.removeChild($notification)
      }, 500)
    })
  })
})
