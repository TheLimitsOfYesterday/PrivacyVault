class EncryptionController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
  end

  def encrypt
    uploaded_file = params[:file]
    password = params[:password]

    if uploaded_file.nil? || password.blank?
      render json: { error: 'File And Password Are Required' }, status: :unprocessable_entity
      return
    end

    begin
      # Read the file content
      file_content = uploaded_file.read

      # Generate random IV (16 bytes for AES)
      iv = OpenSSL::Cipher.new('AES-256-CBC').random_iv

      # Derive key from password using PBKDF2
      salt = OpenSSL::Random.random_bytes(16)
      key = OpenSSL::PKCS5.pbkdf2_hmac(password, salt, 100000, 32, OpenSSL::Digest::SHA256.new)

      # Encrypt the file
      cipher = OpenSSL::Cipher.new('AES-256-CBC')
      cipher.encrypt
      cipher.key = key
      cipher.iv = iv

      encrypted_data = cipher.update(file_content) + cipher.final

      # Combine salt + iv + encrypted_data
      output = salt + iv + encrypted_data

      # Send Encrypted File
      send_data output,
        filename: "#{uploaded_file.original_filename}.enc",
        type: 'application/octet-stream',
        disposition: 'attachment'
    rescue => e
      render json: { error: "Encryption Failed: #{e.message}" }, status: :internal_server_error
    end
  end

  def decrypt
    uploaded_file = params[:file]
    password = params[:password]

    if uploaded_file.nil? || password.blank?
      render json: { error: 'File and Password Are Required' }, status: :unprocessable_entity
      return
    end

    begin
      # Read Encrypted File
      encrypted_content = uploaded_file.read

      # Extarct Salt, IV, and Encrypted Data
      salt = encrypted_content[0..15]
      iv = encrypted_content[16..31]
      encrypted_data = encrypted_content[32..-1]

      # Derive key from password
      key = OpenSSL::PKCS5.pbkdf2_hmac(password, salt, 100000, 32, OpenSSL::Digest::SHA256.new)

      # Decrypt the file
      decipher = OpenSSL::Cipher.new('AES-256-CBC')
      decipher.decrypt
      decipher.key = key
      decipher.iv = iv

      decrypted_data = decipher.update(encrypted_data) + decipher.final

      # Remove .enc extension if present
      original_filename = uploaded_file.original_filename.sub(/\.enc$/,'')

      # Send Decrypted File
      send_data decrypted_data,
        filename: original_filename,
        type: 'application/octet-stream',
        disposition: 'attachment'
    rescue OpenSSL::Cipher::CipherError
      render json: { error: 'Decryption Failed: Invalid Password or Corrupted File' }, status: :unprocessable_entity
    rescue => e
      render json: { error: "Decryption Failed: #{e.message}" }, status: :internal_server_error
    end
  end
end
