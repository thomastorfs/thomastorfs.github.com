path = require 'path'
Jimp = require 'jimp'
mkdirp = require 'mkdirp'

class Resizers
  createImage: (options) ->
    # Create the new filename
    filedest = path.parse(options.source).name + '-' + options.suffix + '.jpg'

    # Define the public destination
    dest = '/images/' + options.dest + '/' + filedest

    # Make sure that the directory exists
    mkdirp('public/images/' + options.dest, (err) ->
      if (err)
        throw err

      # Resize the image
      Jimp.read(options.source, (err, img) ->
        if (err)
          throw err

        # Resize the image
        img.resize(options.w, Jimp.AUTO)
          .cover(options.w, options.h)
          .quality(80)
          .greyscale()
          .write('public' + dest)
      )
    )

    return dest

module.exports = Resizers
