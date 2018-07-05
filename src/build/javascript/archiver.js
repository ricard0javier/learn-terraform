const fs = require('fs');
const fsExtra = require('fs-extra');
const archiver = require('archiver');

const inputDir = process.argv[2];
const outputFile = process.argv[3];

fsExtra.ensureFileSync(outputFile);

// create a file to stream archive data to.
const output = fs.createWriteStream(outputFile);

const archive = archiver('zip', {
    zlib: { level: 9 } // Sets the compression level.
});

// good practice to catch warnings (ie stat failures and other non-blocking errors)
archive.on('warning', err => {
    if (err.code === 'ENOENT') {
        // log warning
        console.warn(err)
    } else {
        // throw error
        throw err;
    }
});

// good practice to catch this error explicitly
archive.on('error', err => {
    throw err;
});

// pipe archive data to the file
archive.pipe(output);

// append files from a sub-directory, putting its contents at the root of archive
archive.directory(inputDir, false);

// finalize the archive (ie we are done appending files but streams have to finish yet)
// 'close', 'end' or 'finish' may be fired right after calling this method so register to them beforehand
archive.finalize();