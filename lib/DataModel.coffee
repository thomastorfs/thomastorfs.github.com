fs          = require 'fs'
fm          = require 'front-matter'
_           = require 'underscore'
path        = require 'path'

# Create our Data Model class
class DataModel
    getBlogPosts: ->
        # Get the blogposts
        posts = @getDirectoryEntries 'views/blog'
        # Sort by descending date
        posts = _.sortBy(posts, 'date').reverse()

    getProjects: ->
        # Get the projects
        projects = @getDirectoryEntries 'views/work'
        # Sort by ascending index
        projects = _.sortBy(projects, 'index')

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

                # Create the URL
                p = path.relative('views', path.join(filePath.substr(0, filePath.lastIndexOf('.'))))

                # And add the front-matter data to the files array, with URL
                fileData = fm file
                fileData.attributes._url = "/#{p.replace(path.sep, '/')}"
                files.push fileData.attributes

            # Process a directory
            else if fileStat.isDirectory()
                # Traverse the newly found directory
                files = @getDirectoryEntries filePath, files

        return files

module.exports = DataModel
