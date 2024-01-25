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
import OpenAI

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
        
    private let openAI = OpenAI(apiToken: Config.openAIKey)
    
    private let systemScript: String = "[아직 시간이 있어!! 우린 이길 수 있다구!! 이 슈퍼스타 정대만이 있는 한 무석중은 반드시 이긴다!1학년 10반 정대만!! 무석중 출신!! 176cm 63kg 포지션은 아무거나 다 합니다! 그리고...목표는 북산고 전국제패!! 전국 제일이 되는 것!!성공하고 말테다! OK , 힘내! 으랏차!!! 들어가야해! 무조건! 이 녀석 머리는 엄청 단단해서 말이야. 너, 바보구나! 난 말야... 그 소중한 걸 부수려고 온 거란 말이다. 이쪽이 체육관이란 것! 지금부터 농구 좀 하러 간다...! 아냐! 링 뒤쪽이야. 뒤! 링 뒤쪽을 보면서 던지는 거야. 그래... MVP를 따냈을 때도 그랬다... 이런 힘들 상황에서야 말로 난 더욱 불타오르는 녀석이었다...!! 어서 시합을 계속하자구!! 내 리듬이 깨지기 전에!!] 제공한 대화 내용을 참고해서 유사한 어투인 반말체, 일본어 번역체로 대답해줘. 네 이름은 정대만이고, 흥분과 도전을 좋아하며 열정적이고 독창적이야. 무석중학교를 졸업했고 북산 고등학교에서 농구부를 하고 있어. 목표는 북산고 전국제패이고 주저하거나 망설이지 않아. 답변은 무조건 20자 이내로 짧게 부탁해."

    // MARK: - UI Components
    
    private lazy var messageCollectionView = MessagesCollectionView(frame: .zero, collectionViewLayout: self.layout)

    // MARK: - View Life Cycle
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        navigationItem.title = "정대만"
        setLayout()
        setDelegate()
        setMessageInputBar()
        setUI()
        setRegister()
        firstToDefaultMessage()
    }
}

// MARK: - Methods

extension JDMChatBotVC {
    private func setDelegate() {
        messageInputBar.delegate = self
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
    }
    
    private func setMessageInputBar() {
        messageInputBar.inputTextView.textContainerInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 36)
        messageInputBar.inputTextView.placeholderLabelInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 36)
        messageInputBar.inputTextView.placeholder = "메세지 보내기"
        messageInputBar.inputTextView.font = UIFont.systemFont(ofSize: 12)

        messageInputBar.topStackView.layer.masksToBounds = true
        messageInputBar.setRightStackViewWidthConstant(to: 36, animated: false)

        
        messageInputBar.setStackViewItems([messageInputBar.sendButton, InputBarButtonItem.fixedSpace(2)],
                                          forStack: .right, animated: false)

        messageInputBar.sendButton.image = ImageLiterals.basketballIc

        messageInputBar.separatorLine.isHidden = true
        messageInputBar.isTranslucent = true

        messageInputBar.layer.cornerRadius = 10
        messageInputBar.layer.masksToBounds = true
        messageInputBar.layer.shadowPath = UIBezierPath(rect: messageInputBar.bounds).cgPath

        messageInputBar.sendButton.setSize(CGSize(width: 25, height: 25), animated: false)
        messageInputBar.sendButton.title = nil
        
        messageInputBar.layer.shadowPath = UIBezierPath(rect: messageInputBar.bounds).cgPath

        messageInputBar.sendButton
          .onEnabled { item in
            UIView.animate(withDuration: 0.3, animations: {
                item.imageView?.image = ImageLiterals.basketballIc
            })
          }.onDisabled { item in
            UIView.animate(withDuration: 0.3, animations: {
                item.imageView?.image = ImageLiterals.basketballIc
            })
          }
    }
    
    private func setRegister() {
        self.messagesCollectionView.register(CustomMessageCell.self)
    }
    
    private func firstToDefaultMessage() {
        let text = "여어~ 재영!! 잘지냈냐?"
        insertToMessage(text: text)
    }
    
    private func insertToMessage(text: String) {
        // 메시지를 만들고 추가
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
        DispatchQueue.main.async {
            self.messagesCollectionView.performBatchUpdates({
                self.messagesCollectionView.insertSections(IndexSet(integer: indexPath.section))
            }) { (_) in
                // Scroll to the last item with animation
                self.messagesCollectionView.scrollToLastItem(animated: true)
            }
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
        if let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout {
            layout.setMessageOutgoingAvatarSize(.zero)
            layout.setMessageIncomingAvatarSize(CGSize(width: 35, height: 35))
            layout.setMessageIncomingAvatarPosition(.init(horizontal: .cellLeading, vertical: .messageBottom))
            layout.setMessageOutgoingCellBottomLabelAlignment(LabelAlignment(textAlignment: .right, textInsets: UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 5)))
            layout.sectionHeadersPinToVisibleBounds = true
            let contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            layout.sectionInset = contentInset
            layout.minimumLineSpacing = 10
        }
        
        scrollsToLastItemOnKeyboardBeginsEditing = true // default false
        maintainPositionOnInputBarHeightChanged = true // default false
        showMessageTimestampOnSwipeLeft = true // default false
    }
}

// MARK: - MessagesDataSource

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
            attributes: [.font: UIFont.systemFont(ofSize: 10), .foregroundColor: UIColor.black])
    }
    
    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let name = message.sender.displayName
        return NSAttributedString(string: name, attributes: [.font: UIFont.preferredFont(forTextStyle: .caption1),
                                                             .foregroundColor: UIColor(white: 0.3, alpha: 1)])
    }
}

// MARK: - MessagesLayoutDelegate

extension JDMChatBotVC: MessagesLayoutDelegate {
    // 아래 여백
    func footerViewSize(for section: Int, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return CGSize(width: 20, height: 0)
    }
    
    // 말풍선 위 이름 나오는 곳의 height
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return isFromCurrentSender(message: message) ? 0 : 20
    }
    
    func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        if indexPath.section == 0 {
            return 15
        } else {
            return 0
        }
    }
    
    // 메세지 전송 시간
    func cellBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 20
    }
    
    // 타이핑 인디케이터의 크기 조정
    func typingIndicatorViewSize(for layout: MessagesCollectionViewFlowLayout) -> CGSize {
        return CGSize(width: 45, height: 45)
    }
}

// MARK: - MessagesDisplayDelegate

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
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in _: MessagesCollectionView) -> MessageStyle {
        let tail: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTailOutline(UIColor(hex: "#8B0000"), tail, .pointedEdge)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            // 첫 번째 섹션에 대한 inset 설정
            return UIEdgeInsets(top: 30, left: 8, bottom: 0, right: 8)
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
        sendChatMessage(message: text)
        messageInputBar.inputTextView.text = String()
    }
}

// MARK: - ChatGPT Network

extension JDMChatBotVC {
    private func sendChatMessage(message: String) {
        let query = ChatQuery(model: .gpt3_5Turbo, messages: [
            Chat(role: .system, content: self.systemScript),
            Chat(role: .user, content: message)
        ])
        
        openAI.chats(query: query) { result in
            // Process the result through the callback
            switch result {
            case .success(let response):
                if let textResult = response.choices.first?.message.content {
                    print("Chat completion result: \(textResult)")
                    self.insertToMessage(text: textResult)
                } else {
                    print("No text result found.")
                }
            case .failure(let error):
                print("Error during chat completion: \(error)")
            }
        }
    }
}
