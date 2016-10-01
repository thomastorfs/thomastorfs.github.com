fs          = require 'fs'
fm          = require 'front-matter'
_           = require 'underscore'
path        = require 'path'

# Create our Model class
class DataController
    getBlogPosts: ->
        posts = []

        # Read all files
        files = fs.readdirSync 'blog'

        # Process each one individually
        _.each files, (file, index) ->
            # Get the full path
            filePath = path.join('blog/', file)

            # If the path is a file
            fileStat = fs.statSync(filePath)
            if fileStat.isFile()
                # Read it
                post = fs.readFileSync(filePath, 'utf8')

                # And add the front-matter data to the posts array, with URL
                postData = fm post
                postData.attributes._url = path.join('/', filePath.substr(0, filePath.lastIndexOf('.')))
                posts.push postData.attributes

        # Sort the posts by descending date
        posts = _.sortBy(posts, 'date').reverse()

        return posts

module.exports = DataController
