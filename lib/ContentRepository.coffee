fs          = require 'fs'
fm          = require 'front-matter'
_           = require 'underscore'
path        = require 'path'

# Create our Content Repository class
class ContentRepository
    getGroupedBlogPosts: ->
        posts = @getDirectoryEntries 'views/blog'
        posts = _.groupBy(posts, '_parsedYear')
        years = _.sortBy(Object.keys(posts), (key) => key).reverse()
        groupedPosts = []
        _.each(years, (year) => groupedPosts.push(_.sortBy(posts[year], '_parsedDate').reverse()))
        groupedPosts

    getBlogPosts: ->
        posts = @getDirectoryEntries 'views/blog'
        posts = _.sortBy(posts, '_parsedDate').reverse()
        posts

    getReading: ->
        reading = @getDirectoryEntries 'views/reading'
        reading = _.sortBy(reading, 'index')

    getReadingBest: ->
        reading = @getDirectoryEntries 'views/reading'
        reading = _.filter(reading, (entry) => entry.score == 5)
        reading = _.sortBy(reading, 'index')

    getReadingOther: ->
        reading = @getDirectoryEntries 'views/reading'
        reading = _.filter(reading, (entry) => entry.score < 5)
        reading = _.sortBy(reading, 'index')

    getReadingSorted: ->
        reading = @getDirectoryEntries 'views/reading'
        reading = _.sortBy(reading, '_parsedDate').reverse()
        reading

    getProjects: ->
        projects = @getDirectoryEntries 'views/work'
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

                # And add the front-matter data to the files array, with URL
                if fm.test file
                    # Get the front-matter
                    fileData = fm file

                    # Create the URL and add it to the file data
                    p = path.relative('views', path.join(filePath.substr(0, filePath.lastIndexOf('.'))))
                    fileData.attributes._url = "/#{p.replace(path.sep, '/')}"
                    fileData.attributes._parsedDate = new Date(fileData.attributes.date)
                    fileData.attributes._parsedYear = fileData.attributes._parsedDate.getFullYear()
                    fileData.attributes._parsedMonth = fileData.attributes._parsedDate.toLocaleString('default', {month: 'short'})
                    fileData.attributes._parsedDay = fileData.attributes._parsedDate.getDate()

                    # Add the file data to the files array
                    files.push fileData.attributes

            # Process a directory
            else if fileStat.isDirectory()
                # Traverse the newly found directory
                files = @getDirectoryEntries filePath, files

        return files

module.exports = ContentRepository
