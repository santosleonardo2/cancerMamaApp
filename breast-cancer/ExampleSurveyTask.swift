//
//  SurveyTask.swift
//  Teste
//
//  Created by leonardo on 1/25/16.
//  Copyright © 2016 Leonardo. All rights reserved.
//

import Foundation
import ResearchKit

public var ExampleSurveyTask: ORKOrderedTask {
    var steps = [ORKStep]()
    
    //Add questions
    //Create introduction screen to survey
    let introStep = ORKInstructionStep(identifier: "intro")
    introStep.title = NSLocalizedString("Questionário", comment: "")
    introStep.text = NSLocalizedString("Siga as instruções a seguir para responder cada pergunta.", comment: "")
    steps += [introStep]
    
    //To see more types of questions, go to: http://researchkit.org/docs/docs/Survey/CreatingSurveys.html
    
    //Create simple text question
    let nameAnswerFormat = ORKTextAnswerFormat(maximumLength: 20)
    nameAnswerFormat.multipleLines = false
    let nameQuestionStepTitle = "Qual o seu nome?"
    let nameQuestionStep = ORKQuestionStep(identifier: "QuestionStep", title: nameQuestionStepTitle, answer: nameAnswerFormat)
    steps += [nameQuestionStep]
    
    //Create boolean queston
    let questionStep = ORKQuestionStep(identifier: "cancer_mama", title: NSLocalizedString("Doença", comment: ""), answer: ORKBooleanAnswerFormat())
    questionStep.text = NSLocalizedString("Você tem câncer de mama?", comment: "")
    steps += [questionStep]
    
    //Create scale question
    let dailyExerciseStep = ORKQuestionStep(identifier: "atividade_fisica",
                                            title: "Atividade Física",
                                            answer: ORKScaleAnswerFormat(maximumValue: 5,
                                                                        minimumValue: 0,
                                                                        defaultValue: 0,
                                                                        step: 1))
    dailyExerciseStep.text = "Quantas vezes você faz exercícios físico por dia?"
    steps += [dailyExerciseStep]
    
    //Create time question
    let doctorTimeStep = ORKQuestionStep(identifier: "horario_medico",
        title: "Médico",
        answer: ORKDateAnswerFormat(style: .DateAndTime))
    doctorTimeStep.text = "Quando é sua próxima consulta?"
    steps += [doctorTimeStep]
    
    //Create text choice question
    let formStep = ORKFormStep(identifier: "synmptoms",
                                title: NSLocalizedString("Sintomas", comment: ""),
                                text: "Qual destes é um sintoma de câncer de mama em seu estágio inicial?")
    let choiceFormat = ORKTextChoiceAnswerFormat(style: .SingleChoice,
        textChoices: [
            ORKTextChoice(text: NSLocalizedString("Não há sintomas.", comment: ""), value: "Nenhum"),
            ORKTextChoice(text: NSLocalizedString("Dores abdominais.", comment: ""), value: "DoresAbdomiais"),
            ORKTextChoice(text: NSLocalizedString("Náusea.", comment: ""), value: "Nausea"),
            ORKTextChoice(text: NSLocalizedString("Anemia.", comment: ""), value: "Anemia")])
    let interestItem = ORKFormItem(identifier: "interest",
                                    text: "",
                                    answerFormat: choiceFormat)
    formStep.formItems = [interestItem]
    steps += [formStep]
    
    //Create another text choice question
    let questQuestionStepTitle = "Qual o seu objetivo?"
    let textChoices = [
        ORKTextChoice(text: "Encontrar a cura do câncer de mama.", value: 0),
        ORKTextChoice(text: "Ter alívio no dia-a-dia.", value: 1),
        ORKTextChoice(text: "Passar tempo.", value: 2)
    ]
    let questAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.SingleChoice, textChoices: textChoices)
    let questQuestionStep = ORKQuestionStep(identifier: "TextChoiceQuestionStep", title: questQuestionStepTitle, answer: questAnswerFormat)
    steps += [questQuestionStep]
    
    //Create an image choice question
    let colorQuestionStepTitle = "Qual a sua cor favorita?"
    let colorTuples = [
        (UIImage(named: "red")!, "Vermelho"),
        (UIImage(named: "orange")!, "Laranja"),
        (UIImage(named: "yellow")!, "Amarelo"),
        (UIImage(named: "green")!, "Verde"),
        (UIImage(named: "blue")!, "Azul"),
        (UIImage(named: "purple")!, "Roxo")
    ]
    let imageChoices : [ORKImageChoice] = colorTuples.map {
        return ORKImageChoice(normalImage: $0.0, selectedImage: nil, text: $0.1, value: $0.1)
    }
    let colorAnswerFormat: ORKImageChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormatWithImageChoices(imageChoices)
    let colorQuestionStep = ORKQuestionStep(identifier: "ImageChoiceQuestionStep", title: colorQuestionStepTitle, answer: colorAnswerFormat)
    steps += [colorQuestionStep]
    
    //Create text answer question
    let feelingStep = ORKQuestionStep(identifier: "sentimentos", title: "Sentimentos", answer: ORKTextAnswerFormat(maximumLength: 255))
    feelingStep.title = "Sentimentos"
    feelingStep.text = "Como você se sente hoje?"
    steps += [feelingStep]
    
    //Add summary step
    let summaryStep = ORKInstructionStep(identifier: "summary")
    summaryStep.title = NSLocalizedString("Agradecimentos", comment: "")
    summaryStep.text = NSLocalizedString("Seus dados foram coletados. Obrigado por participar da nossa pesquisa!", comment: "")
    steps += [summaryStep]
    
    return ORKOrderedTask(identifier: "SurveyTasks", steps: steps)
}