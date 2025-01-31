# Flutter Project
## sharing and playing with other people
###
// Comments
// * Infomation
// ? Should thise
// TODO: TODOthings
// ! Alert

### 데이터베이스 관계도
PetVideo
  ├── 기본 비디오 정보 (id, url, description 등)
  ├── Pet 정보 (petName, petType, breed)
  └── User 정보 (ownerId, ownerName, ownerProfileImage)

User
  ├── 기본 사용자 정보 (id, name, email 등)
  ├── Pet[] (소유한 반려동물 목록)
  └── Comment[] (작성한 댓글 목록)

Pet
  └── 반려동물 기본 정보 (id, name, type 등)

Comment
  └── 댓글 기본 정보 (id, content, likeCount 등)

[PetVideo]
  ├── 1:1 ──> [Pet] (한 비디오는 한 반려동물에 대한 것)
  └── 1:1 ──> [User] (한 비디오는 한 사용자가 소유)
              └── 1:N ──> [Pet] (한 사용자는 여러 반려동물 소유 가능)
              └── 1:N ──> [Comment] (한 사용자는 여러 댓글 작성 가능)

[Comment]
  └── N:1 ──> [PetVideo] (한 비디오에 여러 댓글 가능)
  └── N:1 ──> [User] (한 사용자가 여러 댓글 작성 가능)