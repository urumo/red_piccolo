find app -type f -name '*.rb' | while read -r file; do
  echo "Processing: ${file}"

  # Define the target file path in the .sig folder
  target_file="./.sig/${file}"
  to_create="${target_file}s"

  # Check if the target file exists
  if [ -f "${to_create}" ]; then
    echo "File exists: ${to_create}"
  else
    echo "File does not exist: ${to_create}"

    # Extract the directory part from the target file path
    target_dir=$(dirname "${target_file}")

    # Create the directory structure in the .sig folder
    mkdir -p "${target_dir}"

    # Create the file in the .sig folder
    touch "${to_create}"
    bundle exec rbs prototype rb "${file}" > "${to_create}"
  fi
done