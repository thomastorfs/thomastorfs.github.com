_       = require 'underscore'
fs      = require 'fs'
path    = require 'path'
Jimp    = require 'jimp'
mkdirp  = require 'mkdirp'

class ImageResizer
    createImage: (opts) ->
        # Complete the config with defaults where necessary.
        options = _.defaults(opts, {
            crop: true,
            quality: 80
        })

        # Create the new filename
        filedest = path.parse(options.source).name + '-' + options.suffix + '.jpg'

        # Define the public destination
        dest = '/images/' + options.dest + '/' + filedest

        # Check if the final image exists, if not, create it
        fs.stat('public' + dest, (err, stat) ->
            if (err && err.code == 'ENOENT')
                # Make sure that the directory exists
                mkdirp('public/images/' + options.dest, (err) ->
                    if (err)
                        throw err

                    # Resize the image
                    Jimp.read(options.source, (err, img) ->
                        if (err)
                            throw err

                        # Resize the image
                        if (options.crop)
                            img.cover(options.w, options.h)
                                .quality(options.quality)
                                .write('public' + dest)
                        else
                            img.resize(options.w, Jimp.AUTO)
                                .quality(options.quality)
                                .write('public' + dest)
                    )
                )
        )

        return dest

module.exports = ImageResizer
