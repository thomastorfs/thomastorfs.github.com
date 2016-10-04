fs          = require 'fs'
fm          = require 'front-matter'
_           = require 'underscore'
path        = require 'path'

# Create our Model class
class DataController
    getBlogPosts: ->
        posts = @getDirectoryEntries 'blog'

    getProjects: ->
        projects = @getDirectoryEntries 'work'

    getDirectoryEntries: (directory, files = []) =>
        # Read all files
        entries = fs.readdirSync directory

        # Process each entry individually
        _.each entries, (entry, index) =>
            # Get the full path
            filePath = path.join(directory, entry)

            # What kind of entry is it?
            fileStat = fs.statSync(filePath)

            # Process an individual file
            if fileStat.isFile() && path.extname(entry) == '.jade'
                # Read it
                file = fs.readFileSync(filePath, 'utf8')

                # And add the front-matter data to the files array, with URL
                fileData = fm file
                fileData.attributes._url = path.join('/', filePath.substr(0, filePath.lastIndexOf('.')))
                files.push postData.attributes

            # Process a directory
            else if fileStat.isDirectory()
                # Traverse the newly found directory
                files = @getDirectoryEntries filePath, files

        # Sort the files by descending date
        files = _.sortBy(files, 'date').reverse()

        return files

module.exports = DataController
