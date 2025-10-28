import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "nameCell", "nameDisplay", "nameInput", "surnameCell", "surnameDisplay", "surnameInput",
    "emailCell", "emailDisplay", "emailInput", "phoneCell", "phoneDisplay", "phoneInput",
    "categoryCell", "categoryDisplay", "categoryInput", "editButton", "saveButton", "cancelButton", "deleteButton"
  ]
  static values = { contactId: Number }

  connect() {
  }

  edit(event) {
    event.preventDefault()
    event.stopPropagation()
    this.nameDisplayTarget.style.display = "none"
    this.nameInputTarget.style.display = "block"
    
    this.surnameDisplayTarget.style.display = "none"
    this.surnameInputTarget.style.display = "block"
    
    this.emailDisplayTarget.style.display = "none"
    this.emailInputTarget.style.display = "block"
    
    this.phoneDisplayTarget.style.display = "none"
    this.phoneInputTarget.style.display = "block"
    
    this.categoryDisplayTarget.style.display = "none"
    this.categoryInputTarget.style.display = "block"
    
    this.editButtonTarget.style.display = "none"
    this.saveButtonTarget.style.display = "inline-block"
    this.deleteButtonTarget.style.display = "none"
    this.cancelButtonTarget.style.display = "inline-block"
  }

  cancel(event) {
    if (event) {
      event.preventDefault()
      event.stopPropagation()
    }
    this.nameDisplayTarget.style.display = "inline"
    this.nameInputTarget.style.display = "none"
    
    this.surnameDisplayTarget.style.display = "inline"
    this.surnameInputTarget.style.display = "none"
    
    this.emailDisplayTarget.style.display = "inline"
    this.emailInputTarget.style.display = "none"
    
    this.phoneDisplayTarget.style.display = "inline"
    this.phoneInputTarget.style.display = "none"
    
    this.categoryDisplayTarget.style.display = "inline"
    this.categoryInputTarget.style.display = "none"
    
    this.editButtonTarget.style.display = "inline-block"
    this.saveButtonTarget.style.display = "none"
    this.deleteButtonTarget.style.display = "inline-block"
    this.cancelButtonTarget.style.display = "none"
  }

  save(event) {
    event.preventDefault()

    const contactId = this.contactIdValue
    const url = `/contacts/${contactId}`
    
    const data = {
      contact: {
        name: this.nameInputTarget.value,
        surname: this.surnameInputTarget.value,
        email: this.emailInputTarget.value,
        phone: this.phoneInputTarget.value,
        category: this.categoryInputTarget.value
      }
    }

    fetch(url, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      body: JSON.stringify(data)
    })
    .then(response => {
      if (response.ok) {
        return response.json()
      }
      throw new Error('Network response was not ok')
    })
    .then(contact => {
      this.nameDisplayTarget.textContent = contact.name
      this.surnameDisplayTarget.textContent = contact.surname
      this.emailDisplayTarget.textContent = contact.email
      this.phoneDisplayTarget.textContent = contact.phone || ''
      this.categoryDisplayTarget.textContent = contact.category_display
      
      this.showFlashMessage('Kontakt został pomyślnie zaktualizowany.', 'notice')
      
      this.cancel()
    })
    .catch(error => {
      this.showFlashMessage('Wystąpił błąd podczas zapisywania kontaktu.', 'alert')
    })
  }
  
  showFlashMessage(message, type) {
    const flashContainer = document.getElementById('flash_messages')
    if (flashContainer) {
      flashContainer.innerHTML = `<div class="alert alert-${type}">${message}</div>`

      setTimeout(() => {
        flashContainer.innerHTML = ''
      }, 3000)
    }
  }
}
