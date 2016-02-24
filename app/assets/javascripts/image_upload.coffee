
$ ->
  MEGA_BYTE = 1024000
  $inputFile = $("input[id$='data_stream']")
  $inputImageTitle = $("input[id$='image_title']")
  $divLoadedImage = $('#div_loaded_image')
  $divInputImageOptions = $('#input_image_options')
  $divMessageErrorInputImage = $('#message_error_input_image')
  $divInputImageField = $('#div_input_image_field')

  $inputFile.on 'change', ->
    $divInputImageField.removeClass "error"
    $divMessageErrorInputImage.text ""
    $divMessageErrorInputImage.hide()
    if $inputFile.val()
      s = $inputFile.val().split("\\")
      ss = s[s.length-1].split(".")

      if ss[1] isnt "jpg"
        $divMessageErrorInputImage.text "A extensão da imagem deve ser .jpg"
        $divInputImageField.addClass "error"
        $divMessageErrorInputImage.show()
        $inputFile.val('')
        return false
      else if this.files[0].size > (2*MEGA_BYTE)
        $divMessageErrorInputImage.text "O tamanho do arquivo não deve ultrapassar 2MB."
        $divInputImageField.addClass "error"
        $divMessageErrorInputImage.show()
        $inputFile.val('')
        return false

      $divInputImageOptions.hide()
      $divLoadedImage.show()
      $inputImageTitle.val(ss[0])
    else
      $divInputImageOptions.show()
      $divLoadedImage.hide()

  $('#remove_selected_image').on 'click', ->
    $inputFile.val('')
    $inputImageTitle.val('')
    $divInputImageOptions.show()
    $divLoadedImage.hide()

