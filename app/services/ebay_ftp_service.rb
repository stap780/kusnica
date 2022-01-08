class EbayFtpService

  def self.send_file(filename)
    require 'net/sftp'
    puts '=====>>>> СТАРТ send_file ftp '+Time.now.to_s

    sftp_url = "mip.ebay.com"
    username = EbaySetup.first.ebay_username || ''
    password = EbaySetup.first.ebay_password || ''
    directory = "/store/product/#{filename}"
    localfile = "#{Rails.public_path}/#{filename}"

    Net::SFTP.start( sftp_url, username, :password => password ) do |sftp|
      # upload a file or directory to the remote host
      sftp.upload!( localfile, directory)

      # download a file or directory from the remote host
      # sftp.download!("/path/to/remote", "/path/to/local")

      # grab data off the remote host directly to a buffer
      # data = sftp.download!("/path/to/remote")

      # open and write to a pseudo-IO for a remote file
      # sftp.file.open("/path/to/remote", "w") do |f|
      #   f.puts "Hello, world!\n"
      # end

      # open and read from a pseudo-IO for a remote file
      # sftp.file.open("/path/to/remote", "r") do |f|
      #   puts f.gets
      # end

      # create a directory
      # sftp.mkdir! "/path/to/directory"

      # list the entries in a directory
      # sftp.dir.foreach("/path/to/directory") do |entry|
      #   puts entry.longname
      # end
    end

    puts '=====>>>> FINISH send_file ftp '+Time.now.to_s

    current_process = "=====>>>> FINISH send_file ftp - #{Time.now.to_s}"
  	ProductMailer.notifier_process(current_process).deliver_now
  end

  def self.get_files
    require 'open-uri'
    puts '=====>>>> СТАРТ ftp get_files '+Time.now.to_s


    puts '=====>>>> FINISH ftp get_files '+Time.now.to_s

    current_process = "=====>>>> Ftp get_files - #{Time.now.to_s}"
  	ProductMailer.notifier_process(current_process).deliver_now
  end

end
