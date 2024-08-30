# git clone https://github.com/AIVIETNAMResearch/VN_Multi_User_Video_Search.git
# mv VN_Multi_User_Video_Search AIChallange2023
# echo "Rename succesfully from VN_Multi_User_Video_Search to AIChallange2023"

# ROOT_DIR="AIChallange2023"
# cd "$ROOT_DIR" || exit

#============================================================================
# # Check if gdown is installed
# if ! command -v gdown &> /dev/null
# then
#     echo "gdown is not installed. Please install it using: pip install gdown"
#     exit 1
# fi
# # Function to download a file
# download_file() {
#     local file_id="$1"
#     local output_name="$2"
    
#     if [ -f "$output_name" ]; then
#         echo "File $output_name already exists. Skipping download."
#     else
#         echo "============================================================================"
#         echo "Downloading $output_name..."
#         gdown "$file_id" -O "$output_name"
        
#         if [ $? -eq 0 ]; then
#             echo "Successfully downloaded $output_name"
#         else
#             echo "Failed to download $output_name"
#         fi
#     fi
# }

# # Array of file IDs and their corresponding output names
# declare -A files=(
#     ["1_3Z-iR5b3cT-QAfY6u1oUf9__YNju4m1"]="faiss_clip_cosine.bin"
#     ["1CZDLrRlOK7jmvTc-p6jARR4BA6PSA61M"]="faiss_clipv2_cosine.bin"
#     ["1pjArVhbXljkpCLpFGg71rh2yzwXGeJWi"]="dict.zip"
# )

# # Download each file
# for file_id in "${!files[@]}"; do
#     download_file "$file_id" "${files[$file_id]}"
# done

# # Extract the zip file
# if [ -f "dict.zip" ]; then
#     echo "Extracting dict.zip..."
#     unzip dict.zip 
#     if [ $? -eq 0 ]; then
#         echo "Successfully extracted dict.zip"
        
#         # Move .bin files to the extracted folder
#         echo "Moving .bin files to the extracted folder..."
#         mv *.bin dict/
#         rm -rf dict.zip
#         if [ $? -eq 0 ]; then
#             echo "Successfully moved .bin files"
#         else
#             echo "Failed to move .bin files"
#         fi
#     else
#         echo "Failed to extract dict.zip"
#     fi
# else
#     echo "dict.zip not found. Skipping extraction."
# fi


#============================================================================
# Function to download a Kaggle dataset
download_dataset() {
    local dataset="$1"
    local download_dir="$2"
    echo "Downloading $dataset to $download_dir..."
    if kaggle datasets download -d "$dataset" -p "$download_dir"; then
        echo "Successfully downloaded $dataset to $download_dir"
    else
        echo "Failed to download $dataset"
        return 1
    fi
}

# Function to download a group of datasets
download_group() {
    local group_name="$1"
    local download_dir="$2"
    shift 2
    local datasets=("$@")

    echo "============================================================================"
    echo "Downloading $group_name to $download_dir"
    mkdir -p "$download_dir"
    for dataset in "${datasets[@]}"; do
        download_dataset "$dataset" "$download_dir" || echo "Warning: Failed to download $dataset"
    done
}

# Main script
echo "Started to download Keyframes and Raw videos from Kaggle"
mkdir -p "frontend/ai/public/data/KeyFrames"
mkdir -p "frontend/ai/public/data/dataset"

# Keyframes datasets
keyframes_dir="frontend/ai/public/data/KeyFrames"
keyframes_datasets=(
    "khitrnhxun/aic-keyframesb1-reduced"
    "khitrnhxun/aic-keyframesb1-extra-reduced"
    "khitrnhxun/aic-keyframesb2-reduced"
    "khitrnhxun/aic-keyframesb2-extra-reduced"
    "khitrnhxun/aic-keyframesb3-reduced"
)

# Raw video datasets
raw_video_dir="frontend/ai/public/data/dataset"
raw_video_datasets=(
    "superheroinmordenday/c00-vidieo"
    "khitrnhxun/aic-videob1v2"
    "superheroinmordenday/aic-vidieob1v2"
    "khitrnhxun/aic-videob3-0"
    "superheroinmordenday/aic-b2-v3"
    "nguynlngnamanh/aic-videob3-2"
)

# Download Keyframes
# download_group "Keyframes" "$keyframes_dir" "${keyframes_datasets[@]}"

# Download Raw videos
download_group "Raw videos" "$raw_video_dir" "${raw_video_datasets[@]}"

echo "All downloads completed and processed files completed."
