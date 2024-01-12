//
//  JDMChatBotVC.swift
//  swift-example
//
//  Created by 픽셀로 on 1/11/24.
//

import UIKit

import SnapKit
import Then
import MessageKit
import InputBarAccessoryView

class CustomMessageCell: MessageContentCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class JDMChatBotVC: MessagesViewController {
    
    // MARK: - Properties
    
    private var messages = [MessageModel]()
    
    private let jdmSender = Sender(senderId: "jdm", displayName: "정대만")
    private let meSender = Sender(senderId: "me", displayName: "나")
    
    private let layout = MessagesCollectionViewFlowLayout()
    
    // MARK: - UI Components
    
    private lazy var messageCollectionView = MessagesCollectionView(frame: .zero, collectionViewLayout: self.layout)

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionViewLayoutLayout()
        setDelegate()
        setMessageInputBar()
        setUI()
        self.messagesCollectionView.register(CustomMessageCell.self)
        firstToDefaultMessage()
    }
}

// MARK: - Methods

extension JDMChatBotVC {
    private func setCollectionViewLayoutLayout() {
        // 각 셀 설정
        if let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout {
            layout.setMessageOutgoingAvatarSize(.zero)
            layout.setMessageIncomingAvatarSize(CGSize(width: 35, height: 35))
            layout.setMessageIncomingAvatarPosition(.init(horizontal: .cellLeading, vertical: .messageBottom))
            layout.setMessageOutgoingMessageTopLabelAlignment(LabelAlignment(textAlignment: .right, textInsets: .zero))
            layout.setMessageIncomingMessageTopLabelAlignment(LabelAlignment(textAlignment: .left, textInsets: .zero))
            layout.sectionHeadersPinToVisibleBounds = true
            
            // 1. 아이템의 크기 설정
//                layout.itemSize = CGSize(width: messagesCollectionView.bounds.width - 20, height: 100)

            // 2. 콘텐츠와 인셋 고려
            let contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            layout.sectionInset = contentInset
            layout.minimumLineSpacing = 10
        }
    }
    
    private func setDelegate() {
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        scrollsToLastItemOnKeyboardBeginsEditing = true // default false
        maintainPositionOnInputBarHeightChanged = true // default false
        showMessageTimestampOnSwipeLeft = true // default false
    }
    
    private func setMessageInputBar() {
        inputBarType = .custom(messageInputBar)
        messageInputBar.delegate = self
        messageInputBar.setRightStackViewWidthConstant(to: 36, animated: false)

        messageInputBar.isTranslucent = true
        messageInputBar.inputTextView.tintColor = .blue

        messageInputBar.topStackView.layer.borderWidth = 30

        messageInputBar.inputTextView.textContainerInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 36)
        messageInputBar.inputTextView.placeholderLabelInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 36)

        messageInputBar.inputTextView.font = UIFont.systemFont(ofSize: 12)
        messageInputBar.inputTextView.placeholder = "메세지 보내기"

        messageInputBar.sendButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        messageInputBar.sendButton.setSize(CGSize(width: 45, height: 45), animated: false)
        messageInputBar.sendButton.image = ImageLiterals.pochacoFaceImg
        messageInputBar.sendButton.title = nil
        
        // This just adds some more flare
        messageInputBar.sendButton
          .onEnabled { item in
            UIView.animate(withDuration: 0.3, animations: {
                item.imageView?.image = ImageLiterals.pochacoFaceImg
            })
          }.onDisabled { item in
            UIView.animate(withDuration: 0.3, animations: {
                item.imageView?.image = ImageLiterals.pochacoFaceImg
            })
          }
    }
    
    private func firstToDefaultMessage() {
        let text = "여어~ 재영!! 잘지냈냐?"
        
        insertToMessage(text: text)
    }
    
    private func insertToMessage(text: String) {
        // 메시지를 만들고 추가하는 로직을 수행합니다.
        let attributedText = NSAttributedString(
            string: text,
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
                NSAttributedString.Key.foregroundColor: UIColor(hex: "#8B0000")
            ]
        )
        
        let message = MessageModel(messageId: "jdm", kind: .attributedText(attributedText), sender: jdmSender, sentDate: Date())
        
        insertNewMessage(message)
    }
    
    private func insertNewMessage(_ message: MessageModel) {
        // Append the new message to your data source
        self.messages.append(message)

        // Calculate the index path for the new section
        let indexPath = IndexPath(item: 0, section: messages.count - 1)
        
        // Perform batch updates to insert the new section
        self.messagesCollectionView.performBatchUpdates({
            self.messagesCollectionView.insertSections(IndexSet(integer: indexPath.section))
        }) { (_) in
            // Scroll to the last item with animation
            self.messagesCollectionView.scrollToLastItem(animated: true)
        }
    }
    
    func isLastSectionVisible() -> Bool {
        guard !messages.isEmpty else { return false }

        let lastIndexPath = IndexPath(item: 0, section: messages.count - 1)

        return messagesCollectionView.indexPathsForVisibleItems.contains(lastIndexPath)
    }
}

// MARK: - UI & Layout

extension JDMChatBotVC {
    private func setUI() {
        view.backgroundColor = .white
        self.messagesCollectionView.backgroundColor = .clear
    }
    
    private func setLayout() {
        
    }
}

extension JDMChatBotVC: MessagesDataSource {
    var currentSender: MessageKit.SenderType {
        return meSender
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        
        let dateString = dateFormatter.string(from: message.sentDate)
        
        if indexPath.section == 0 {
          return NSAttributedString(
            string: dateString,
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
                NSAttributedString.Key.foregroundColor: UIColor.black
            ]
          )
        }
        return nil
    }
    
    func cellBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"

        let dateString = dateFormatter.string(from: message.sentDate)

        return NSAttributedString(
            string: dateString,
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
                NSAttributedString.Key.foregroundColor: UIColor.black
            ]
        )
    }
    
    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let name = message.sender.displayName
        return NSAttributedString(string: name, attributes: [.font: UIFont.preferredFont(forTextStyle: .caption1),
                                                             .foregroundColor: UIColor(white: 0.3, alpha: 1)])
    }
}

extension JDMChatBotVC: MessagesLayoutDelegate {
    // 아래 여백
    func footerViewSize(for section: Int, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return CGSize(width: 10, height: 0)
    }
    
    // 말풍선 위 이름 나오는 곳의 height
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 20
    }
    
    func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 10
    }
    
    // 타이핑 인디케이터의 크기 조정
    func typingIndicatorViewSize(for layout: MessagesCollectionViewFlowLayout) -> CGSize {
        return CGSize(width: 45, height: 45)
    }
}

extension JDMChatBotVC: MessagesDisplayDelegate {
    // 말풍선의 배경 색상
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? UIColor(hex: "#8B0000") : .white
    }
    
    // 말풍선 오른쪽에
    func isFromCurrentSender(message: MessageType) -> Bool {
        // 여기에서 != 로 하면 왼쪽에서 나오고, == 로 하면 오른쪽에서 나온다
        return message.sender.senderId == currentSender.senderId
    }
    
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .white : .white
    }
    
    // 말풍선의 꼬리 모양 방향
    func messageStyle(for message: MessageType, at _: IndexPath, in _: MessagesCollectionView) -> MessageStyle {
        let tail: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTailOutline(UIColor(hex: "#8B0000"), tail, .pointedEdge)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            // 첫 번째 섹션에 대한 inset 설정
            return UIEdgeInsets(top: 150, left: 8, bottom: 0, right: 8)
        } else {
            // 나머지 섹션에 대한 inset 설정
            return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        }
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at _: IndexPath, in _: MessagesCollectionView) {
        let avatar = Avatar(image: ImageLiterals.jdmProfileImg)
        avatarView.set(avatar: avatar)
    }
}

// MARK: - InputBarAccessoryViewDelegate

extension JDMChatBotVC: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        // 메시지를 만들고 추가하는 로직을 수행합니다.
        let attributedText = NSAttributedString(
            string: text,
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]
        )
        
        let message = MessageModel(messageId: "me", kind: .attributedText(attributedText), sender: currentSender, sentDate: Date())
        
        insertNewMessage(message)
        print(text)

        messageInputBar.inputTextView.text = String()
    }
}
