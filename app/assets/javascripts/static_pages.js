$(() => {
  $("#micropost_image").bind("change", function validateImageSize() {
    const sizeInMB = this.files[0].size / 1024 / 1024

    if (sizeInMB > 5) {
      alert("Maximum file size is 5MB. Please choose a smaller file.") // eslint-disable-line no-alert
    }
  })
})
